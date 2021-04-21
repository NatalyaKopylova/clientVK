//
//  UserPhotoCollectionViewController.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class UserPhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos = [UIImage?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserPhotosCollectionViewCell.self), for: indexPath) as! UserPhotosCollectionViewCell
        cell.imageView.image = photos[indexPath.row]
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
