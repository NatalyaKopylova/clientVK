//
//  VKService.swift
//  clientVK
//
//  Created by Natalia on 11.06.2021.
//

import Foundation
import Alamofire
import PromiseKit

class VKService {
    
    func getFriends(completion: (() -> Void)? = nil) {
        AF.request(VKAPI.getFriends(fields: "nickname,sex,photo_100")).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion?()
                return
            }
            let users = items.map { (item) -> User in
                return User(json: item)
            }
            DataStorage.saveDataToRealm(objects: users)
            completion?()
        }.resume()
    }
    
    func getGroups(completion: (([[String : Any]]) -> Void)? = nil) {
        AF.request(VKAPI.getGroups(fields: "description")).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion?([[String : Any]]())
                return
            }
            completion?(items)
        }.resume()
    }
    
    func parse(items: [[String : Any]] ) -> [Group] {
        return items.map { (item) -> Group in
            return Group(json: item)
        }
    }
    
    func saveGroups(groups: [Group]) {
        DataStorage.saveDataToRealm(objects: groups)
    }
    
    func getGroups() -> Promise<[[String : Any]]> {
        return Promise { seal in
            getGroups { groups in
                seal.resolve(groups, nil)
            }
        }
    }
    
    func getPhotos(ownerId: Int, completion: (() -> Void)? = nil) {
        AF.request(VKAPI.getPhotos(ownerId: ownerId)).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion?()
                return
            }
            let photos = items.map { (item) -> Photo in
                return Photo(json: item)
            }
            DataStorage.saveDataToRealm(objects: photos)
            completion?()
        }.resume()
    }
    
    func getNews(completion: (([News]) -> Void)? = nil) {
        DispatchQueue.global().async {
            AF.request(VKAPI.getNews).response { (response) in
                guard let items = self.handleResponse(response) else {
                    completion?([News]())
                    return
                }
                completion?(items.map({ News(json: $0) }))
            }.resume()
        }
    }
    
    func getUser(id: Int, completion: (() -> Void)? = nil) {
        DispatchQueue.global().async {
            AF.request(VKAPI.getUser(id: id)).response { (response) in
                let responseData = try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
                guard let res = responseData["response"] as? [String: Any] else {
                    completion?()
                    return
                }
                let user = User(json: res)
                DataStorage.saveDataToRealm(objects: [user])
                completion?()
            }.resume()
        }
    }
    
    func getGroup(id: Int, completion: (() -> Void)? = nil) {
        DispatchQueue.global().async {
            AF.request(VKAPI.getGroup(id: id)).response { (response) in
                let responseData = try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
                guard let res = responseData["response"] as? [String: Any] else {
                    completion?()
                    return
                }
                let group = Group(json: res)
                DataStorage.saveDataToRealm(objects: [group])
                completion?()
            }.resume()
        }
    }
    
    private func handleResponse(_ response: AFDataResponse<Data?>) -> [[String: Any]]? {
        let responseData = try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
        guard let res = responseData["response"] as? [String: Any] else {
            return nil
        }
        return res["items"] as? [[String: Any]]
    }
}
