//
//  DataStorage.swift
//  clientVK
//
//  Created by Natalia on 11.06.2021.
//

import Foundation
import RealmSwift

class DataStorage {
    static func saveDataToRealm<T: Object & HasIdProtocol>(objects: [T]) {
        do {
            let realm = try Realm()
            objects.forEach { object in
                if realm.objects(T.self).filter("id == %@", object.id).count == 0 {
                    try? realm.write {
                        realm.add(object)
                    }
                }
            }
        } catch  {
           print (error)
        }
    }
}
