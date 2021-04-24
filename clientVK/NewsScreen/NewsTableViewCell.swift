//
//  NewsTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 22.04.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var fhotoCollectionView: UICollectionView!
    
    @IBOutlet weak var likeButton: MyButtonNewsScreen!
    
    @IBOutlet weak var commentButton: MyButtonNewsScreen!
    
    @IBOutlet weak var repostButton: MyButtonNewsScreen!
    
    @IBOutlet weak var viewingCountLabel: UILabel!
    
    private var photos = [UIImage]()
    
    func configWith(news: News) {
        titleLabel.text = news.title
        likeButton.text = String(news.like)
        commentButton.text = String(news.comment)
        repostButton.text = String(news.repost)
        viewingCountLabel.text = String(news.viewing)
        self.photos = news.newsPhotos
        
        fhotoCollectionView.dataSource = self
        fhotoCollectionView.reloadData()
    }
    
    override func prepareForReuse() {
        fhotoCollectionView.dataSource = nil
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = photos[indexPath.row]
        return cell
    }    
}
