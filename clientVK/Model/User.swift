//
//  User.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import Foundation
import UIKit

struct User {
    let id: Int
    let name: String
    var age: UInt?
    var avatar: String? 
    
    init(json: [String: Any]) {
        self.id = json["id"] as! Int
        self.name = (json["first_name"] as! String) + " " + (json["last_name"] as! String)
        self.avatar = json["photo_100"] as? String
    }
}
