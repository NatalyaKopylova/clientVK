//
//  Photo.swift
//  clientVK
//
//  Created by Natalia on 01.06.2021.
//

import Foundation

struct Photo {
     
    let id: Int
    let sizes: [PhotoSize]
    
    init(json: [String: Any]) {
        self.id = json["id"] as! Int
        self.sizes = (json["sizes"] as! [[String: Any]]).map({ PhotoSize(json: $0)})
    }
}

