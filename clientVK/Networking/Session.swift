//
//  Session.swift
//  clientVK
//
//  Created by Natalia on 24.05.2021.
//

import Foundation
import Alamofire
import RealmSwift

class Session {
    
    var token: String?
    var userId: Int?

    static let shared = Session()

    private init() {}
    
    func getFriends(completion: @escaping () -> Void) {
        AF.request(VKAPI.getFriends(fields: "nickname,sex,photo_100")).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion()
                return
            }
            let users = items.map { (item) -> User in
                return User(json: item)
            }
            self.saveDataToRealm(objects: users)
            completion()
        }.resume()
    }
    
    func getGroups(completion: @escaping () -> Void) {
        AF.request(VKAPI.getGroups(fields: "description")).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion()
                return
            }
            let groups = items.map { (item) -> Group in
                return Group(json: item)
            }
            self.saveDataToRealm(objects: groups)
            completion()
        }.resume()
    }
    
    func getPhotos(ownerId: Int, completion: @escaping () -> Void) {
        AF.request(VKAPI.getPhotos(ownerId: ownerId)).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion()
                return
            }
            let photos = items.map { (item) -> Photo in
                return Photo(json: item)
            }
            self.saveDataToRealm(objects: photos)
            completion()
        }.resume()
    }
    
    private func handleResponse(_ response: AFDataResponse<Data?>) -> [[String: Any]]? {
        let responseData = try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
        guard let res = responseData["response"] as? [String: Any] else {
            return nil
        }
        return res["items"] as? [[String: Any]]
    }
    
    func saveDataToRealm<T: Object & HasIdProtocol>(objects: [T]) {
        do {
//            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm()
            objects.forEach { object in
                if realm.objects(T.self).filter("id == %@", object.id).count == 0 {
                    try? realm.write {
                        realm.add(object)
                    }
                }
            }
//            try realm.commitWrite()
        } catch  {
           print (error)
        }
    }
}
