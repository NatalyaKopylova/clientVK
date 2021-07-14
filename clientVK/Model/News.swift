//
//  News.swift
//  clientVK
//
//  Created by Natalia on 22.04.2021.
//

import Foundation
import UIKit

struct News {
    
    enum NewsType {
        case post
        case photo
    
    }
    
    let type: NewsType
    let sourceId: Int
    var timeOfNewsCreation: Date
    var text: String?
    var newsPhotos: [Photo]
    var like: Int
    var comment: Int
    var repost: Int
    var viewing = 0
    
    init(json: [String: Any]) {
        self.type = (json["type"] as! String) == "photo" ? .photo : .post
        self.sourceId = json["source_id"] as! Int
        self.timeOfNewsCreation = Date(timeIntervalSince1970: json ["date"] as! Double)
        self.text = json["text"] as? String
        var photos = [Photo]()
        if let attachments = json["attachments"] as? [[String: Any]] {
            attachments.forEach { item in
                if item["type"] as! String == "photo" {
                    photos.append(Photo(json: item["photo"] as! [String: Any]))
                }
            }
        }
        self.newsPhotos = photos
        self.like = (json["likes"] as? [String: Any])?["count"] as? Int ?? -1
        self.comment = (json["comments"] as? [String: Any])?["count"] as? Int ?? -1
        self.repost = (json["reposts"] as? [String: Any])?["count"] as? Int ?? -1
    }
}
