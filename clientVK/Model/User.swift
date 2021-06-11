//
//  User.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import Foundation
import UIKit
import RealmSwift


class User: Object, HasIdProtocol  {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
//    @objc dynamic var age: Int?
    @objc dynamic var avatar: String?

    
    convenience init(json: [String: Any]) {
        self.init()
        self.id = json["id"] as! Int
        self.name = (json["first_name"] as! String) + " " + (json["last_name"] as! String)
        self.avatar = json["photo_100"] as? String
    }
}
