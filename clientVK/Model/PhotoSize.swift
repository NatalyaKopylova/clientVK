//
//  PhotoSize.swift
//  clientVK
//
//  Created by Natalia on 01.06.2021.
//

import Foundation
import RealmSwift

class PhotoSize: Object {
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var width: Int = 0
    var aspectRatio: CGFloat { CGFloat(width)/CGFloat(height) }
        
    convenience init (json: [String: Any]) {
        self.init()
        self.height = json["height"] as! Int
        self.url = json["url"] as! String
        self.type = json["type"] as! String
        self.width = json["width"] as! Int
    }
}
