//
//  Group.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import Foundation
import UIKit
import RealmSwift

class Group: Object, HasIdProtocol {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var groupDescription: String?
    @objc dynamic var groupImage: String?
    
    convenience init(json: [String: Any]) {
        self.init()
        self.id = json["id"] as! Int
        self.name = json["name"] as! String 
        self.groupDescription = json["description"] as? String
        self.groupImage = json["photo_100"] as? String
    }
}
