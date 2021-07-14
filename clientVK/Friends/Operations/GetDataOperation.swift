//
//  GetDataOperation.swift
//  clientVK
//
//  Created by Natalia on 14.07.2021.
//

import Foundation
import Alamofire

class GetDataOperation: Operation {
    
    var outputData: Data?
     
    override func main() {
        let sem = DispatchSemaphore(value: 0)
        AF.request(VKAPI.getFriends(fields: "nickname,sex,photo_100")).response { (response) in
            self.outputData = response.data
            sem.signal()
        }.resume()
        sem.wait()
    }
}
