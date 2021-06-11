//
//  Photo.swift
//  clientVK
//
//  Created by Natalia on 01.06.2021.
//

import Foundation
import RealmSwift

class Photo: Object, HasIdProtocol {
     
    @objc dynamic var id: Int = 0
    var sizes: List<PhotoSize> = List<PhotoSize>()
    
    convenience init(json: [String: Any]) {
        self.init()
        self.id = json["id"] as! Int
        let sizesArray = (json["sizes"] as! [[String: Any]]).map({ PhotoSize(json: $0)})
        self.sizes.append(objectsIn: sizesArray)
    }
}

