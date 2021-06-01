//
//  Session.swift
//  clientVK
//
//  Created by Natalia on 24.05.2021.
//

import Foundation
import Alamofire

class Session {
    
    var token: String?
    var userId: Int?

    static let shared = Session()

    private init() {}
    
    func getFriends(completion: @escaping ([User]) -> Void) {
        AF.request(VKAPI.getFriends(fields: "nickname,sex,photo_100")).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion([User]())
                return
            }
            let users = items.map { (item) -> User in
                return User(json: item)
            }
            completion(users)
        }.resume()
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        AF.request(VKAPI.getGroups(fields: "description")).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion([Group]())
                return
            }
            let groups = items.map { (item) -> Group in
                return Group(json: item)
            }
            completion(groups)
        }.resume()
    }
    
    func getPhotos(ownerId: Int, completion: @escaping ([Photo]) -> Void) {
        AF.request(VKAPI.getPhotos(ownerId: ownerId)).response { (response) in
            guard let items = self.handleResponse(response) else {
                completion([Photo]())
                return
            }
            let photos = items.map { (item) -> Photo in
                return Photo(json: item)
            }
            completion(photos)
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
