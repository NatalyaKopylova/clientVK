//
//  UserPhotoCollectionViewController.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import UIKit
import Alamofire
import RealmSwift

private let reuseIdentifier = "Cell"

class UserPhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var realm: Realm!
    var token: NotificationToken?
    var photoResults: Results<Photo>!
    var photos: [Photo] { photoResults.map { $0 }}
    var userId: Int!
    let service = VKService()

    override func viewDidLoad() {
        super.viewDidLoad()
            do {
                realm = try Realm()
                photoResults = realm.objects(Photo.self).filter("ownerId == %@", userId)
            } catch {
                print(error)
            }
         
        service.getPhotos(ownerId: userId)
    
        token = photoResults.observe(on: DispatchQueue.main, { _ in
        self.collectionView.reloadData()
    })
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
        let photo = photos[indexPath.row]
        if let size = photo.sizes.first(where: { $0.type == "m"}), let url = URL(string: size.url) {
            cell.imageView.af.setImage(withURL: url)
        }
        cell.startAnimate()
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let cell = collectionView.cellForItem(at: indexPath)!
////        let galleryVC = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        
//        galleryVC.modalPresentationStyle = .custom
//        let images = photos.filter { $0 != nil }.map { $0! }
//        let convertedFromFrame = view.convert(cell.frame, from: collectionView)
//        galleryVC.setImages(images: images, currentIndex: indexPath.row, fromFrame: convertedFromFrame)
//        galleryVC.setupTransition()
//        self.present(galleryVC, animated: true, completion: nil)
//        performSegue(withIdentifier: "showGalleryPhoto", sender: (indexPath.row, cell.frame))
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? GalleryViewController,
//              let (index, frame) = sender as? (Int, CGRect)
//        else {return}
//        let images = photos.filter { $0 != nil }.map { $0! }
//        destination.setImages(images: images, currentIndex: index, fromFrame: frame)
//    }
}
