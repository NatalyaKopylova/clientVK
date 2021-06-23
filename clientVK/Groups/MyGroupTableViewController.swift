//
//  MyGroupTableViewController.swift
//  clientVK
//
//  Created by Natalia on 15.04.2021.
//

import UIKit
import RealmSwift
import Firebase

class MyGroupTableViewController: UITableViewController {
    
    var realm: Realm!
    var token: NotificationToken?
    var myGroupsResults: Results<Group>!
    var myGroups: [Group] { myGroupsResults.map { $0 }.sorted(by: { $0.name < $1.name }) }
    let service = VKService()
    
    var favoriteGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: String(describing: GroupTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: GroupTableViewCell.self))
            
        do {
                realm = try Realm()
                myGroupsResults = realm.objects(Group.self)
            } catch {
                print(error)
            }
        
        service.getGroups()
        token = myGroupsResults.observe(on: DispatchQueue.main, { _ in
            self.tableView.reloadData()
        })
        
        let groupsRef = Database.database().reference().child("users/\(Session.shared.userId!)/groups")
        groupsRef.observe(.value) { snapshot in
            guard let value = snapshot.value as? String else { return }
            let ids = value.split(separator: ",").map { Int($0)! }
            self.favoriteGroups = self.myGroups.filter({ids.contains($0.id)})

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupTableViewCell.self), for: indexPath) as! GroupTableViewCell
        let group = myGroups[indexPath.row]
        
        cell.groupNameLabel.text = group.name
        cell.groupDescriptionLabel.text = group.groupDescription
        if let myGroupsUrl = group.groupImage, let url = URL(string: myGroupsUrl) {
            cell.groupImageView.af.setImage(withURL: url)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavouriteAction = UIContextualAction(style: .normal, title: "Избранное") { _, _, completion in
            self.addToFavourits(group: self.myGroups[indexPath.row])
            completion(true)
        }
        
        addToFavouriteAction.image = UIImage(systemName: "star")
        addToFavouriteAction.backgroundColor = UIColor.systemOrange
        return UISwipeActionsConfiguration(actions: [addToFavouriteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? FavoriteGroupsTableViewController else { return }
        destination.myGroups = myGroups
    }
    
    func addToFavourits(group: Group) {
        guard favoriteGroups.filter({ $0.id == group.id }).count == 0 else { return }
        var ids = favoriteGroups.reduce("") { res, group in
            if res.count == 0 {
                return "\(group.id)"
            } else {
                return res + ",\(group.id)"
            }
        }
        if ids.count == 0 {
            ids = "\(group.id)"
        } else {
            ids = ids + ",\(group.id)"
        }
        let groupsRef = Database.database().reference().child("users/\(Session.shared.userId!)/groups")
        groupsRef.setValue(ids)
    }
}
