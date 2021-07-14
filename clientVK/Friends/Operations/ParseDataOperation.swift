//
//  ParseDataOperation.swift
//  clientVK
//
//  Created by Natalia on 14.07.2021.
//

import Foundation

class ParseDataOperations: Operation {
    
    var outputData: [User]?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.outputData,
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let res = json["response"] as? [String: Any],
            let items = res["items"] as? [[String: Any]]
        else { return }
        let users = items.map { (item) -> User in
            return User(json: item)
        }
        outputData = users
    }
}
