//
//  NewsPhotoTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 07.07.2021.
//

import UIKit
import AlamofireImage

class NewsPhotoTableViewCell: UITableViewCell, UICollectionViewDataSource {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var aspect: NSLayoutConstraint!
    
    var photos = [Photo]() {
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
        if let stringUrl = photos[indexPath.row].sizes.first(where: { $0.type == "x" })?.url, let url = URL(string: stringUrl) {
            cell.imageView.setImage(at: url)
        }
        return cell
    }
    override func prepareForReuse() {
        photosCollectionView.dataSource = nil
    }

}
