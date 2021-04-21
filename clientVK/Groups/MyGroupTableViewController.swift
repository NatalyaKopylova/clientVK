//
//  MyGroupTableViewController.swift
//  clientVK
//
//  Created by Natalia on 15.04.2021.
//

import UIKit

class MyGroupTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: GroupTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: GroupTableViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupTableViewCell.self), for: indexPath) as! GroupTableViewCell
        let group = DataStorage.shared.myGroups[indexPath.row]
        
        cell.groupNameLabel.text = group.name
        cell.groupDescriptionLabel.text = group.description
        cell.groupImageView.image = group.groupImage

        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataStorage.shared.myGroups.remove(at: indexPath.row)
        self.tableView.reloadData()
    }
}
