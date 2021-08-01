//
//  NewsScreenViewController.swift
//  clientVK
//
//  Created by Natalia on 22.04.2021.
//

import UIKit

class NewsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let service = VKService()
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getNews(completion: {news in self.news = news
            self.tableView.reloadData()
        })
        

    }
    
    func makeInfoCell(newsItem: News) -> NewsInfoTableViewCell {
        let infoCell = tableView.dequeueReusableCell(withIdentifier: "NewsInfoTableViewCell") as! NewsInfoTableViewCell
        infoCell.likeButton.text = String(newsItem.like)
        infoCell.commentsButton.text = String(newsItem.comment)
        infoCell.repostButton.text = String(newsItem.repost)
        infoCell.viewsCountLabel.text = String(newsItem.viewing)
        return infoCell
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
            headerCell.timeOfNewsCreationLabel.text = newsItem.timeOfNewsCreation.string("d MMMM yyyy H:mm")
            cell = headerCell
            
        case 1:
            if hasText {
                let textCell = tableView.dequeueReusableCell(withIdentifier: "NewsTextTableViewCell") as! NewsTextTableViewCell
                textCell.textNewsLabel.text = newsItem.text
                cell = textCell
            } else if !hasText && hasPhoto {
                let photoCell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell") as! NewsPhotoTableViewCell
                photoCell.photos = newsItem.newsPhotos
                cell = photoCell
            } else {
                cell = makeInfoCell(newsItem: newsItem)
            }
            
        case 2:
            if hasText && hasPhoto {
                let photoCell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell") as! NewsPhotoTableViewCell
                photoCell.photos = newsItem.newsPhotos
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
    
}
