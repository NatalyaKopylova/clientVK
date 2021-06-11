//
//  MyGroupTableViewController.swift
//  clientVK
//
//  Created by Natalia on 15.04.2021.
//

import UIKit
import RealmSwift

class MyGroupTableViewController: UITableViewController {
    
    var realm: Realm!
    var token: NotificationToken?
    var myGroupsResults: Results<Group>!
    var myGroups: [Group] { myGroupsResults.map { $0 }.sorted(by: { $0.name < $1.name }) }
    let service = VKService()
    
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
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        DataStorage.shared.myGroups.remove(at: indexPath.row)
//        self.tableView.reloadData()
//    }

}
