//
//  NewsScreenViewController.swift
//  clientVK
//
//  Created by Natalia on 22.04.2021.
//

import UIKit

class NewsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let segueIdentifier = "showGalleryPhotoFromNews"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataStorage.shared.newsScreen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self)) as! NewsTableViewCell
        let news = DataStorage.shared.newsScreen[indexPath.row]
        cell.configWith(news: news)
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let images = DataStorage.shared.newsScreen[indexPath.row].newsPhotos
        performSegue(withIdentifier: segueIdentifier, sender: images)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GalleryViewController,
           let images = sender as? [UIImage] {
            destination.setImages(images: images, currentIndex: 0)
        }
    }
}
