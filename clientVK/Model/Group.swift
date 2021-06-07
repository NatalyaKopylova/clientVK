//
//  Group.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import Foundation
import UIKit

struct Group {
    let id: Int
    let name: String
    var description: String?
    var groupImage: String?
    
    init(json: [String: Any]) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.description = json["description"] as? String
        self.groupImage = json["photo_100"] as? String
    }
}
