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
        tableView.backgroundColor = .systemOrange
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return DataStorage.shared.friendsWithLetter.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.friendsWithLetter[section].users.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        DataStorage.shared.friendsWithLetter.map { $0.letter }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FirstLetterSectionHeaderView()
        view.letter.text = DataStorage.shared.friendsWithLetter[section].letter
        return view
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self), for: indexPath) as! UserTableViewCell
        let user = DataStorage.shared.friendsWithLetter[indexPath.section].users[indexPath.row]
        cell.nameLabel.text = user.name
        cell.avatar.avatar.image = user.avatar
        cell.ageLabel.text = user.age != nil ? String(user.age!) : nil
        cell.setNeedsLayout()
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showUsersPhotosIdentifier, sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionationVC = segue.destination as? UserPhotoCollectionViewController,
           let userIndex = sender as? IndexPath {
            destionationVC.photos = DataStorage.shared.friendsWithLetter[userIndex.section].users[userIndex.row].photoArray
        }
    }
}
