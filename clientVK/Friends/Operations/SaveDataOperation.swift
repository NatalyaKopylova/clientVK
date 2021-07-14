//
//  SaveDataOperations.swift
//  clientVK
//
//  Created by Natalia on 14.07.2021.
//

import Foundation
import RealmSwift

class SaveDataOperation: Operation {
    
    override func main() {
        guard let operation = dependencies.first as? ParseDataOperations,
              let users = operation.outputData
        else { return }
        DataStorage.saveDataToRealm(objects: users)
    }
}
