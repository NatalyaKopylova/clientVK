//
//  NewsPhotoTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 07.07.2021.
//

import UIKit

class NewsPhotoTableViewCell: UITableViewCell, UICollectionViewDataSource {

    @IBOutlet weak var photosCollectionView: UICollectionView!

    var photos = [UIImage]() {
        didSet {
            photosCollectionView.dataSource = self
            photosCollectionView.reloadData()
        }
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
    override func prepareForReuse() {
        photosCollectionView.dataSource = nil
    }

}
