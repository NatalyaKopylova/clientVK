//
//  VKAPI.swift
//  clientVK
//
//  Created by Natalia on 28.05.2021.
//

import Foundation
import Alamofire

enum VKAPI: URLRequestConvertible {
    
    case getFriends(fields: String)
    case getPhotos
    case getGroups
    case searchGroups
    
    
    var method: HTTPMethod {
        switch self {
        case .getFriends:
            return .get
        case .getPhotos:
            return .get
        case .getGroups:
            return .get
        case .searchGroups:
            return .get
        }
    }
    
    var baseUrl: String { "https://api.vk.com/method" }
    
    var path: String {
        switch self {
        case .getFriends:
            return "friends.get"
        case .getPhotos:
            return "photos.get"
        case .getGroups:
            return "groups.get"
        case .searchGroups:
            return "searchGroups.get"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URL(string: baseUrl)!
        url.appendPathComponent(path)
        var params = Parameters()
        
        var request = URLRequest(url: url)
        
        switch self {
        case .getFriends(let fields):
            params["fields"] = fields
        case .getPhotos:
            break
        case .getGroups:
            break
        case .searchGroups:
            break
        }
        
        params["access_token"] = Session.shared.token
        params["v"] = "5.131"
        
        request = try! URLEncoding.default.encode(request, with: params)
        return request
    }
    
    
    
}

