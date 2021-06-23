//
//  NewsScreenViewController.swift
//  clientVK
//
//  Created by Natalia on 22.04.2021.
//

import UIKit

class NewsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewsTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataStorageOld.shared.newsScreen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self)) as! NewsTableViewCell
        let news = DataStorageOld.shared.newsScreen[indexPath.row]
        cell.configWith(news: news)
        cell.delegate = self
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let images = DataStorageOld.shared.newsScreen[indexPath.row].newsPhotos 
        let galleryVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        
        galleryVC.modalPresentationStyle = .custom
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        let firstCollectionViewCell = cell.fhotoCollectionView.cellForItem(at: IndexPath(row: 0, section: 0))!
        let convertedFromFrame = view.convert(firstCollectionViewCell.frame, from: cell.fhotoCollectionView)
        galleryVC.setImages(images: images, currentIndex: 0, fromFrame: convertedFromFrame)
        galleryVC.setupTransition()
        self.present(galleryVC, animated: true, completion: nil)
        cell.setSelected(false, animated: false)
    }
    
    func didSelectCell(images: [UIImage], currentIndex: Int, collectionView: UICollectionView) {
        let galleryVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        
        galleryVC.modalPresentationStyle = .custom
        let cell = collectionView.cellForItem(at: IndexPath(row: currentIndex, section: 0))!
        let convertedFromFrame = view.convert(cell.frame, from: collectionView)
        galleryVC.setImages(images: images, currentIndex: currentIndex, fromFrame: convertedFromFrame)
        galleryVC.setupTransition()
        self.present(galleryVC, animated: true, completion: nil)
    }
    
}
