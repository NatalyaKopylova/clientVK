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
//        fillUserArray()
//        fillGroupsArray()
//        fillNewsArrey()
    }
    
    var myFrends = [User]()
    
    var allGroups = [Group]()
    var myGroups = [Group]()
    
    var newsScreen = [News]()
    
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
    
//    func fillUserArray() {
//        let user1photoArray = [UIImage(named: "Ivan"), UIImage(named: "Ivan1"), UIImage(named: "Vasya1")]
//        let user1 = User(name: "Ваня", age: 12, avatar: UIImage(named: "Ivan"), photoArray: user1photoArray)
//
//        let user2photoArray = [UIImage(named: "Vasya"), UIImage(named: "Vasya1")]
//        let user2 = User(name: "Вася", age: 15, avatar: UIImage(named: "Vasya"), photoArray: user2photoArray)
//
//        let user3photoArray = [UIImage(named: "Roman"), UIImage(named: "Roman1")]
//        let user3 = User(name: "Рома", age: 11, avatar: UIImage(named: "Roman"), photoArray: user3photoArray)
//
//        let user4photoArray = [UIImage(named: "Sveta"), UIImage(named: "Sveta1")]
//        let user4 = User(name: "Света", age: 17, avatar: UIImage(named: "Sveta"), photoArray: user4photoArray)
//
//        let user5photoArray = [UIImage(named: "Vova"), UIImage(named: "Vova1")]
//        let user5 = User(name: "Вова", age: 14, avatar: UIImage(named: "Vova"), photoArray: user5photoArray)
//
//        let user6photoArray = [UIImage(named: "Sonya"), UIImage(named: "Sonya1")]
//        let user6 = User(name: "Соня", age: 17, avatar: UIImage(named: "Sonya"), photoArray: user6photoArray)
//
//        let user7photoArray = [UIImage(named: "Sacha"), UIImage(named: "Sacha1")]
//        let user7 = User(name: "Саша", age: 15, avatar: UIImage(named: "Sacha"), photoArray: user7photoArray)
//
//        let user8photoArray = [UIImage(named: "Mila"), UIImage(named: "Mila1")]
//        let user8 = User(name: "Мила", age: 12, avatar: UIImage(named: "Mila"), photoArray: user8photoArray)
//
//        let user9photoArray = [UIImage(named: "Lena"), UIImage(named: "Lena1")]
//        let user9 = User(name: "Лена", age: 18, avatar: UIImage(named: "Lena"), photoArray: user9photoArray)
//
//        let user10photoArray = [UIImage(named: "Tanya"), UIImage(named: "Tanya1")]
//        let user10 = User(name: "Таня", age: 9, avatar: UIImage(named: "Tanya"), photoArray: user10photoArray)
//
//        myFrends.append(user1)
//        myFrends.append(user2)
//        myFrends.append(user3)
//        myFrends.append(user4)
//        myFrends.append(user5)
//        myFrends.append(user6)
//        myFrends.append(user7)
//        myFrends.append(user8)
//        myFrends.append(user9)
//        myFrends.append(user10)
//
//        myFrends.sort { $0.name < $1.name }
//    }
    
//    func fillGroupsArray() {
//
//        let group1 = Group(name: "Котики", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Cat"))
//        let group2 = Group(name: "Собакены", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Dog"))
//        let group3 = Group(name: "Baby", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Baby"))
//        let group4 = Group(name: "Прогулка", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Strolls"))
//        let group5 = Group(name: "Спорт", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Sports"))
//        let group6 = Group(name: "Любители покушать", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "FoodLovers"))
//        let group7 = Group(name: "Здоровье", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Health"))
//        let group8 = Group(name: "Хобби", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Hobby"))
//        let group9 = Group(name: "Достижения", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Achievements"))
//        let group10 = Group(name: "Соревнования", description: "Здесь должно быть описание группы", groupImage: UIImage(named: "Сompetitions"))
//
//        allGroups.append(group1)
//        allGroups.append(group2)
//        allGroups.append(group3)
//        allGroups.append(group4)
//        allGroups.append(group5)
//        allGroups.append(group6)
//        allGroups.append(group7)
//        allGroups.append(group8)
//        allGroups.append(group9)
//        allGroups.append(group10)
//
//        allGroups.sort { $0.name < $1.name }
//    }
//
//    func filteredGroups(text: String?) -> [Group] {
//        guard let text = text, text.count > 0 else { return allGroups }
//        return allGroups.filter { $0.name.lowercased().contains(text.lowercased()) }
//    }
//
//    func fillNewsArrey() {
//        let news1 = News(title: "Подойди сюда. Нам давно пора поговорить. Где моя рыбка?!", newsPhotos: [UIImage(named: "conversation")!], like: 100, comment: 0, repost: 0, viewing: 110)
//        let news2 = News(title: "Приветики!", newsPhotos: [UIImage(named: "hello")!, UIImage(named: "conversation")!], like: 100, comment: 2, repost: 0, viewing: 110)
//        let news3 = News(title: "Ну пойдем уже погуляем...", newsPhotos: [UIImage(named: "timeOfGames")!, UIImage(named: "hello")!, UIImage(named: "conversation")!], like: 100, comment: 0, repost: 4, viewing: 110)
//        let news4 = News(title: "Самое время поспать. Уже 11. И не важно, что не ночи.", newsPhotos: [UIImage(named: "sleep")!, UIImage(named: "timeOfGames")!, UIImage(named: "hello")!, UIImage(named: "conversation")!], like: 100, comment: 5, repost: 5, viewing: 115)
//        let news5 = News(title: "Без сомнения, я самый лучший программист. Что тебе нужно подсказать?", newsPhotos: [UIImage(named: "work")!, UIImage(named: "sleep")!, UIImage(named: "timeOfGames")!, UIImage(named: "hello")!, UIImage(named: "conversation")!], like: 99, comment: 4, repost: 0, viewing: 118)
//
//        newsScreen.append(news1)
//        newsScreen.append(news2)
//        newsScreen.append(news3)
//        newsScreen.append(news4)
//        newsScreen.append(news5)
//    }
}
