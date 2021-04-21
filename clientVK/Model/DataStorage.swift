//
//  DataStorage.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import UIKit

struct UsersWithLetter {
    let letter: String
    var users = [User]()
}

class DataStorage {
    
    static let shared = DataStorage()
    
    private init() {
        fillUserArray()
        fillGroupsArray()
    }
    
    var myFrends = [User]()
    
    var allGroups = [Group]()
    var myGroups = [Group]()
    
    var friendsWithLetter: [UsersWithLetter] {
        var arr = [UsersWithLetter]()
        myFrends.forEach { user in
            guard let firstLetter = user.name.first else { return }
            if let index = arr.firstIndex(where: { $0.letter == String(firstLetter) }) {
                arr[index].users.append(user)
            } else {
                let newUsersWithLetter = UsersWithLetter(letter: String(firstLetter), users: [user])
                arr.append(newUsersWithLetter)
            }
        }
        return arr
    }
    
    func fillUserArray() {
        let user1photoArray = [UIImage(named: "Ivan"), UIImage(named: "Ivan1")]
        let user1 = User(name: "Ваня", age: 12, avatar: UIImage(named: "Ivan"), photoArray: user1photoArray)
        
        let user2photoArray = [UIImage(named: "Vasya"), UIImage(named: "Vasya1")]
        let user2 = User(name: "Вася", age: 15, avatar: UIImage(named: "Vasya"), photoArray: user2photoArray)
        
        let user3photoArray = [UIImage(named: "Roman"), UIImage(named: "Roman1")]
        let user3 = User(name: "Рома", age: 11, avatar: UIImage(named: "Roman"), photoArray: user3photoArray)
        
        let user4photoArray = [UIImage(named: "Sveta"), UIImage(named: "Sveta1")]
        let user4 = User(name: "Света", age: 17, avatar: UIImage(named: "Sveta"), photoArray: user4photoArray)
        
        let user5photoArray = [UIImage(named: "Vova"), UIImage(named: "Vova1")]
        let user5 = User(name: "Вова", age: 14, avatar: UIImage(named: "Vova"), photoArray: user5photoArray)
        
        let user6photoArray = [UIImage(named: "Sonya"), UIImage(named: "Sonya1")]
        let user6 = User(name: "Соня", age: 17, avatar: UIImage(named: "Sonya"), photoArray: user6photoArray)
        
        let user7photoArray = [UIImage(named: "Sacha"), UIImage(named: "Sacha1")]
        let user7 = User(name: "Саша", age: 15, avatar: UIImage(named: "Sacha"), photoArray: user7photoArray)
        
        let user8photoArray = [UIImage(named: "Mila"), UIImage(named: "Mila1")]
        let user8 = User(name: "Мила", age: 12, avatar: UIImage(named: "Mila"), photoArray: user8photoArray)
        
        let user9photoArray = [UIImage(named: "Lena"), UIImage(named: "Lena1")]
        let user9 = User(name: "Лена", age: 18, avatar: UIImage(named: "Lena"), photoArray: user9photoArray)
        
        let user10photoArray = [UIImage(named: "Tanya"), UIImage(named: "Tanya1")]
        let user10 = User(name: "Таня", age: 9, avatar: UIImage(named: "Tanya"), photoArray: user10photoArray)
        
        myFrends.append(user1)
        myFrends.append(user2)
        myFrends.append(user3)
        myFrends.append(user4)
        myFrends.append(user5)
        myFrends.append(user6)
        myFrends.append(user7)
        myFrends.append(user8)
        myFrends.append(user9)
        myFrends.append(user10)
        
        myFrends.sort { $0.name < $1.name }
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
