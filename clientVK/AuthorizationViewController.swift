//
//  AuthorizationViewController.swift
//  clientVK
//
//  Created by Natalia on 28.05.2021.
//

import UIKit
import WebKit
import Alamofire

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet{
               webView.navigationDelegate = self
           }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7865993"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "262150"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.131")
                ]
                
                let request = URLRequest(url: urlComponents.url!)
                
                webView.load(request)
    }
}

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        print(token)
        
        if let token = token {
            Session.shared.token = token
        }
    
        performSegue(withIdentifier: "showMain", sender: nil)
//        AF.request(VKAPI.getPhotos).response { (response) in
//            let responseData = try! JSONSerialization.jsonObject(with: response.data!)
//            print("my response1", responseData)
//        }.resume()
//
//        AF.request(VKAPI.getGroups).response { (response) in
//            let responseData = try! JSONSerialization.jsonObject(with: response.data!)
//            print("my response2", responseData)
//        }.resume()
//
//        AF.request(VKAPI.searchGroups).response { (response) in
//            let responseData = try! JSONSerialization.jsonObject(with: response.data!)
//            print("my response3", responseData)
//        }.resume()
        decisionHandler(.cancel)
    }
}
