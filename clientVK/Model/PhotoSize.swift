//
//  PhotoSize.swift
//  clientVK
//
//  Created by Natalia on 01.06.2021.
//

import Foundation

struct PhotoSize {
    let height: Int
    let url: String
    let type: String
    let width: Int
    
    init (json: [String: Any]) {
        self.height = json["height"] as! Int
        self.url = json["url"] as! String
        self.type = json["type"] as! String
        self.width = json["width"] as! Int
    }
}
