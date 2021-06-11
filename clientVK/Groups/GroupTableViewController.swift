//
//  GroupTableViewController.swift
//  clientVK
//
//  Created by Natalia on 14.04.2021.
//

import UIKit

class GroupTableViewController: UITableViewController, MySearchBarViewDelegate {
    

    var searchText: String? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var groups: [Group] {
        return [Group]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: GroupTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: GroupTableViewCell.self))
        
        let searchBarContainer = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let searchBar = MySearchBarView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBarContainer.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor).isActive = true
        searchBar.delegate = self
        tableView.tableHeaderView = searchBarContainer
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupTableViewCell.self), for: indexPath) as! GroupTableViewCell
        let group = groups[indexPath.row]
        
        cell.group = group
        cell.groupNameLabel.text = group.name
        cell.groupDescriptionLabel.text = group.groupDescription
//        cell.groupImageView.image = group.groupImage
        
        cell.didTap = { self.selectRow(tableView, indexPath: indexPath) }

        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(tableView, indexPath: indexPath)
    }
    
    func selectRow(_ tableView: UITableView, indexPath: IndexPath) {
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
    
    func cancelPressed() {
        searchText = nil
    }
    
    func textDidChange(text: String) {
        searchText = text
    }
}