//
//  NewsScreenViewController.swift
//  clientVK
//
//  Created by Natalia on 22.04.2021.
//

import UIKit

class NewsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    @IBOutlet weak var tableView: UITableView!
    
    let service = VKService()
    var news = [News]()
    var nextFrom = ""
    let refreshControl = UIRefreshControl()
    var isLoading = false
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy H:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.tintColor = .systemOrange
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        tableView.addSubview(refreshControl)
        refreshNews()
    }
    
    func makeInfoCell(newsItem: News) -> NewsInfoTableViewCell {
        let infoCell = tableView.dequeueReusableCell(withIdentifier: "NewsInfoTableViewCell") as! NewsInfoTableViewCell
        infoCell.likeButton.text = String(newsItem.like)
        infoCell.commentsButton.text = String(newsItem.comment)
        infoCell.repostButton.text = String(newsItem.repost)
        infoCell.viewsCountLabel.text = String(newsItem.viewing)
        return infoCell
    }
    
    @objc func refreshNews() {
        refreshControl.beginRefreshing()
        let startTime = news.first?.timeOfNewsCreation.timeIntervalSince1970
        service.getNews(startFrom: nil, startTime: startTime) { newNews, nextFrom in
            self.refreshControl.endRefreshing()
            self.nextFrom = nextFrom
            guard newNews.count > 0 else { return }
            self.news = newNews + self.news
            let indexSet = IndexSet(integersIn: 0..<newNews.count)
            self.tableView.insertSections(indexSet, with: .automatic)
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let newsItem = news[section]
        let hasText = newsItem.text != nil
        let hasPhoto = newsItem.newsPhotos.count > 0
        if hasText && hasPhoto { return 4 }
        if !hasText && !hasPhoto { return 2 }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsItem = news[indexPath.section]
        let hasText = newsItem.text != nil
        let hasPhoto = newsItem.newsPhotos.count > 0
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderTableViewCell") as! NewsHeaderTableViewCell
            headerCell.sourceId = newsItem.sourceId
            headerCell.timeOfNewsCreationLabel.text = formatter.string(from: newsItem.timeOfNewsCreation)
            cell = headerCell
            
        case 1:
            if hasText {
                let textCell = tableView.dequeueReusableCell(withIdentifier: "NewsTextTableViewCell") as! NewsTextTableViewCell
                textCell.textNewsLabel.text = newsItem.text
                cell = textCell
            } else if !hasText && hasPhoto {
                let photoCell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell") as! NewsPhotoTableViewCell
                photoCell.photos = newsItem.newsPhotos
                if newsItem.newsPhotos.count == 1,
                   let aspectRatio = newsItem.newsPhotos.first?.sizes.first(where: { $0.type == "x" })?.aspectRatio {
                    photoCell.aspect = photoCell.aspect.setMultiplier(multiplier: aspectRatio)
                } else {
                    photoCell.aspect = photoCell.aspect.setMultiplier(multiplier: 1)
                }

                cell = photoCell
            } else {
                cell = makeInfoCell(newsItem: newsItem)
            }
            
        case 2:
            if hasText && hasPhoto {
                let photoCell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell") as! NewsPhotoTableViewCell
                photoCell.photos = newsItem.newsPhotos
                if newsItem.newsPhotos.count == 1,
                   let aspectRatio = newsItem.newsPhotos.first?.sizes.first(where: { $0.type == "x" })?.aspectRatio {
                    photoCell.aspect = photoCell.aspect.setMultiplier(multiplier: aspectRatio)
                } else {
                    photoCell.aspect = photoCell.aspect.setMultiplier(multiplier: 1)
                }
                cell = photoCell
            } else if !hasText && !hasPhoto {
                break
            } else {
                cell = makeInfoCell(newsItem: newsItem)
            }
            
        case 3:
            if hasText && hasPhoto {
                cell = makeInfoCell(newsItem: newsItem)
            }
            
        default:
            break
        }
        
        return cell
    }
    
//  MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let images = DataStorageOld.shared.newsScreen[indexPath.row].newsPhotos
//        let galleryVC = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
//
//        galleryVC.modalPresentationStyle = .custom
//        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
//        let firstCollectionViewCell = cell.fhotoCollectionView.cellForItem(at: IndexPath(row: 0, section: 0))!
//        let convertedFromFrame = view.convert(firstCollectionViewCell.frame, from: cell.fhotoCollectionView)
////        galleryVC.setImages(images: images, currentIndex: 0, fromFrame: convertedFromFrame)
//        galleryVC.setupTransition()
//        self.present(galleryVC, animated: true, completion: nil)
//        cell.setSelected(false, animated: false)
    }
    
    func didSelectCell(images: [UIImage], currentIndex: Int, collectionView: UICollectionView) {
//        let galleryVC = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
//
//        galleryVC.modalPresentationStyle = .custom
//        let cell = collectionView.cellForItem(at: IndexPath(row: currentIndex, section: 0))!
//        let convertedFromFrame = view.convert(cell.frame, from: collectionView)
////        galleryVC.setImages(images: images, currentIndex: currentIndex, fromFrame: convertedFromFrame)
//        galleryVC.setupTransition()
//        self.present(galleryVC, animated: true, completion: nil)
    }
    
    //MARK: - UITableViewDataSourcePrefetching
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > news.count - 3, !isLoading {
            isLoading = true
            service.getNews(startFrom: nextFrom, startTime: nil) { news, startFrom in
                let indexSet = IndexSet(integersIn: self.news.count ..< self.news.count + news.count)
                self.news.append(contentsOf: news)
                self.tableView.insertSections(indexSet, with: .automatic)
                self.isLoading = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
}


extension NSLayoutConstraint {
    /**
     Change multiplier constraint

     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
    */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
