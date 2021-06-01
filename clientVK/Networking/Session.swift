//
//  Session.swift
//  clientVK
//
//  Created by Natalia on 24.05.2021.
//

import Foundation

class Session {
    
    var token: String?
    var userId: Int?

    static let shared = Session()

    private init() {}    
}
