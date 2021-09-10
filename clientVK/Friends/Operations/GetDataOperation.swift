//
//  GetDataOperation.swift
//  clientVK
//
//  Created by Natalia on 14.07.2021.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    
    var outputData: Data?
 
    override func main() {
       
        AF.request(VKAPI.getFriends(fields: "nickname,sex,photo_100")).response { [weak self] response in
            self?.outputData = response.data
            self?.finished()
           
        }.resume()
        
    }
}
