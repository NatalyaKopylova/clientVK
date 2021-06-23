//
//  VKService.swift
//  clientVK
//
//  Created by Natalia on 11.06.2021.
//

import Foundation
import Alamofire

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
    
    func getGroups(completion: (() -> Void)? = nil) {
        AF.request(VKAPI.getGroups(fields: "description")).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion?()
                return
            }
            let groups = items.map { (item) -> Group in
                return Group(json: item)
            }
            DataStorage.saveDataToRealm(objects: groups)
            completion?()
        }.resume()
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
    
    private func handleResponse(_ response: AFDataResponse<Data?>) -> [[String: Any]]? {
        let responseData = try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
        guard let res = responseData["response"] as? [String: Any] else {
            return nil
        }
        return res["items"] as? [[String: Any]]
    }
}
