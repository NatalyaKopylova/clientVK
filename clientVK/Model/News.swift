//
//  News.swift
//  clientVK
//
//  Created by Natalia on 22.04.2021.
//

import Foundation
import UIKit

struct News {
    
    var avatar: UIImage?
    var autorName: String
    var timeOfNewsCreation: String
    var text: String?
    var newsPhotos: [UIImage]
    var like: UInt
    var comment: UInt
    var repost: UInt
    var viewing: UInt
    
}
