//
//  MyGroupTableViewController.swift
//  clientVK
//
//  Created by Natalia on 15.04.2021.
//

import UIKit
import RealmSwift

class MyGroupTableViewController: UITableViewController {
    
    var myGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        Session.shared.getGroups { () in
            do {
                let realm = try Realm()
                self.myGroups = realm.objects(Group.self).sorted(by: { $0.name < $1.name })
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
        
        let nib = UINib(nibName: String(describing: GroupTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: GroupTableViewCell.self))
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
   
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataStorage.shared.myGroups.remove(at: indexPath.row)
        self.tableView.reloadData()
    }

}
