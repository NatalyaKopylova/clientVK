//
//  VKService.swift
//  clientVK
//
//  Created by Natalia on 11.06.2021.
//

import Foundation
import Alamofire
import PromiseKit

typealias JSON = [String: Any]

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
    
    func getNews(startFrom: String?, startTime: Double? = nil, completion: (([News], String) -> Void)? = nil) {
        DispatchQueue.global().async {
            AF.request(VKAPI.getNews(startFrom: startFrom, startTime: startTime)).response { (response) in
                guard let items = self.handleResponse(response),
                      let data = response.data,
                      let responseJson = try! JSONSerialization.jsonObject(with: data) as? JSON,
                      let vkResponse = responseJson["response"] as? [String: Any],
                      let nextFrom = vkResponse["next_from"] as? String
                else {
                    completion?([News](), "")
                    return
                }
                
                completion?(items.map({ News(json: $0) }), nextFrom)
            }.resume()
        }
    }
    
    func getUser(id: Int, completion: (() -> Void)? = nil) {
        DispatchQueue.global().async {
            AF.request(VKAPI.getUser(id: id)).response { (response) in
                let responseData = try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
                guard let res = responseData["response"] as? [[String: Any]] else {
                    completion?()
                    return
                }
                let users = res.map { User(json: $0) }
                DataStorage.saveDataToRealm(objects: users)
                completion?()
            }.resume()
        }
    }
    
    func getGroup(id: Int, completion: (() -> Void)? = nil) {
        DispatchQueue.global().async {
            AF.request(VKAPI.getGroup(id: id)).response { (response) in
                let responseData = try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
                guard let res = responseData["response"] as? [[String: Any]] else {
                    print("id is", id)
                    completion?()
                    return
                }
                let groups = res.map { Group(json: $0) }
                DataStorage.saveDataToRealm(objects: groups)
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
