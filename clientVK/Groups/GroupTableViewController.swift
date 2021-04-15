//
//  GroupTableViewController.swift
//  clientVK
//
//  Created by Natalia on 14.04.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: GroupTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: GroupTableViewCell.self))
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return DataStorage.shared.allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupTableViewCell.self), for: indexPath) as! GroupTableViewCell
        let group = DataStorage.shared.allGroups[indexPath.row]
        
        cell.group = group
        cell.groupNameLabel.text = group.name
        cell.groupDescriptionLabel.text = group.description
        cell.groupImageView.image = group.groupImage

        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? GroupTableViewCell,
              let group = cell.group
        else {return}
        
        var checkBox = false
        for item in DataStorage.shared.myGroups {
            if item.name == group.name {
                checkBox = true
            }
        }
        if !checkBox {
            DataStorage.shared.myGroups.append(group)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
