//
//  FavoriteGroupsTableViewController.swift
//  clientVK
//
//  Created by Natalia on 21.06.2021.
//

import UIKit
import Firebase

class FavouriteGroupsTableViewController: UITableViewController {

    var favoriteGroups = [Group]()
    var myGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: GroupTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: GroupTableViewCell.self))
        
        let groupsRef = Database.database().reference().child("users/\(Session.shared.userId!)/groups")
        groupsRef.observe(.value) { snapshot in
            guard let value = snapshot.value as? String else { return }
            let ids = value.split(separator: ",").map { Int($0)! }
            self.favoriteGroups = self.myGroups.filter({ids.contains($0.id)})
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupTableViewCell.self), for: indexPath) as! GroupTableViewCell
        let group = favoriteGroups[indexPath.row]
        
        cell.groupNameLabel.text = group.name
        cell.groupDescriptionLabel.text = group.groupDescription
        if let myGroupsUrl = group.groupImage, let url = URL(string: myGroupsUrl) {
            cell.groupImageView.af.setImage(withURL: url)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteFromFavouriteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
            self.removeFromFavourites(at: indexPath.row)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteFromFavouriteAction])
    }
    
    func removeFromFavourites(at index: Int) {
        favoriteGroups.remove(at: index)
        
        let ids = favoriteGroups.reduce("") { res, group in
            if res.count == 0 {
                return "\(group.id)"
            } else {
                return res + ",\(group.id)"
            }
        }
        
        let groupsRef = Database.database().reference().child("users/\(Session.shared.userId!)/groups")
        groupsRef.setValue(ids)
    }

}
