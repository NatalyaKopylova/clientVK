//
//  FriendsTableViewController.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import UIKit
import AlamofireImage
import RealmSwift

class FriendsTableViewController: UITableViewController, UISearchBarDelegate, MySearchBarViewDelegate {
   
    var searchText: String?
    
    func textDidChange(text: String) {
        searchText = text
        tableView.reloadData()
    }
    
    func cancelPressed() {
        searchText = nil
    }
    
    let showUsersPhotosIdentifier = "showUsersPhotos"
    var realm: Realm!
    var token: NotificationToken?
    var usersResult: Results<User>!
    var users: [User] {
        var _users: [User] = usersResult.map { $0 }
        if let searchText = searchText, searchText.count > 0 {
            _users = _users.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        return _users.sorted(by: { $0.name < $1.name })
    }
    let service = VKService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            realm = try Realm()
            usersResult = realm.objects(User.self)
        } catch {
            print(error)
        }
        tableView.backgroundColor = .systemOrange
        
        let queue = OperationQueue()
        let getDataOperation = GetDataOperation()
        let parseDataOperation = ParseDataOperations()
        let saveDataOperetion = SaveDataOperation()
        parseDataOperation.addDependency(getDataOperation)
        saveDataOperetion.addDependency(parseDataOperation)
        queue.addOperations([getDataOperation,parseDataOperation,saveDataOperetion], waitUntilFinished: false)
        
        
        token = usersResult.observe(on: DispatchQueue.main, { _ in
            self.tableView.reloadData()
        })
        
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
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self), for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        if let avatarUrl = user.avatar, let url = URL(string: avatarUrl) {
            cell.avatar.avatar.af.setImage(withURL: url)
        }

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
            let userId = users[userIndex.row].id
            destionationVC.userId = userId
        }
    }
}
