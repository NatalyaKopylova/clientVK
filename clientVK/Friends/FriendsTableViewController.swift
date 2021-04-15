//
//  FriendsTableViewController.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    let showUsersPhotosIdentifier = "showUsersPhotos"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.myFrends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self), for: indexPath) as! UserTableViewCell
        let user = DataStorage.shared.myFrends[indexPath.row]
        cell.nameLabel.text = user.name
        cell.avatar.image = user.avatar
        cell.ageLabel.text = user.age != nil ? String(user.age!) : nil
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showUsersPhotosIdentifier, sender: indexPath.row)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionationVC = segue.destination as? UserPhotoCollectionViewController,
           let userIndex = sender as? Int {
            destionationVC.photos = DataStorage.shared.myFrends[userIndex].photoArray
        }
    }
}
