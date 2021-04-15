//
//  DataStorage.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import UIKit

class DataStorage {
    
    static let shared = DataStorage()
    
    private init() {
        fillUserArray()
        fillGroupsArray()
    }
    
    var myFrends = [User]()
    
    var allGroups = [Group]()
    var myGroups = [Group]()
    
    func fillUserArray() {
        let user1photoArray = [UIImage(named: "Ivan"), UIImage(named: "Vasya")]
        let user1 = User(name: "Ivan", age: 12, avatar: UIImage(named: "Ivan"), photoArray: user1photoArray)
        
        let user2photoArray = [UIImage(named: "Vasya"), UIImage(named: "Ivan")]
        let user2 = User(name: "Vasya", age: 15, avatar: UIImage(named: "Vasya"), photoArray: user2photoArray)
        
        let user3photoArray = [UIImage(named: "Roman"), UIImage(named: "Vova")]
        let user3 = User(name: "Roman", age: 11, avatar: UIImage(named: "Roman"), photoArray: user3photoArray)
        
        let user4photoArray = [UIImage(named: "Sveta"), nil]
        let user4 = User(name: "Sveta", age: 17, avatar: UIImage(named: "Sveta"), photoArray: user4photoArray)
        
        let user5photoArray = [UIImage(named: "Vova"), nil]
        let user5 = User(name: "Vova", age: 14, avatar: UIImage(named: "Vova"), photoArray: user5photoArray)
        
        myFrends.append(user1)
        myFrends.append(user2)
        myFrends.append(user3)
        myFrends.append(user4)
        myFrends.append(user5)
    }
    
    func fillGroupsArray() {

        let group1 = Group(name: "Cat", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Cat"))
        let group2 = Group(name: "Dog", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Dog"))
        let group3 = Group(name: "Baby", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Baby"))
        let group4 = Group(name: "Strolls", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Strolls"))
        let group5 = Group(name: "Sports", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Sports"))
        
        allGroups.append(group1)
        allGroups.append(group2)
        allGroups.append(group3)
        allGroups.append(group4)
        allGroups.append(group5)
    }
}
