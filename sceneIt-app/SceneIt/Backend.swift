//
//  Backend.swift
//  SceneIt
//
//  Created by Jasdip Chauhan on 2017-04-25.
//  Copyright © 2017 Jasdip Chauhan. All rights reserved.
//

import Foundation
import Alamofire

public class Backend {
    
    private static var backendClient: Backend? = nil
    
    static func getInstance() -> Backend {
    
        if (backendClient == nil) {
            backendClient = Backend()
        }
    
        return backendClient!;
    }
    
    let baseURL : String = "http://192.168.0.22:3000/"
    let tokenHeader : String = "X-User-Token"
    let emailHeader : String = "X-User-Email"
    
    private init() {
        
    }
    
    public func loginUser(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
        
        let url = baseURL + "v1/sessions"
        
        let loginCreds: Parameters = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request(url, method: .post, parameters: loginCreds, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.isFailure {
                print("REQUEST FAILURE\(response.result.debugDescription)")
                completionHandler(false)
                return
            }
            
            guard let json = response.result.value! as? Dictionary<String, AnyObject> else {
                print("BACKEND ERROR: PARSE ERROR")
                completionHandler(false)
                return
            }
            guard let user = json["data"]!["user"] as? Dictionary<String, AnyObject> else {
                print("BACKEND ERROR: PARSE ERROR")
                completionHandler(false)
                return
            }
            
            guard let id = user["id"] as? Int,
                let apiToken = user["authentication_token"] as? String,
                let email = user["email"] as? String
                else {
                    completionHandler(false)
                    return
                }
            
            ProfileManager.getProfileManager().setCurrentUser(id: id, email: email, apiToken: apiToken)
            
            completionHandler(true)
        }
    }
    
    public func registerUser(username: String, password: String, email: String, fullname: String) {
        
//        guard let requestUrl = URL(string: baseURL) else { return }
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//        let body = "username=\(username)&password=\(password)&email=\(email)&fullname=\(fullname)"
//        request.httpBody = body.data(using: .utf8)
//        
//        URLSession.shared.dataTask(with: request, completionHandler: {
//            (data, response, error) in
//            
//            if error != nil {
//                print ("Error")
//                return
//            }
//            
//            //callback to UI thread
//            DispatchQueue.main.async( execute: {
//    
//                
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//                    
//                    guard let parsedJson = json else {
//                        print ("Error while parsing")
//                        return
//                    }
//                    
//                    print(parsedJson)
//                    
//                    
//                } catch {
//                    print ("BACKEND (register user): caught an error\(error)")
//                }
//                
//            })
//            
//            
//        }).resume()
    }
    
    //MARK: Business Logic Methods
    
    public func getPosts(completionHandler: @escaping (Bool, Array<Post>?) -> Void) {
        
        let user = ProfileManager.getProfileManager().getCurrentUser()!
        
        let url = baseURL + "v1/posts"
        let headers = [
            tokenHeader: user.apiToken,
            emailHeader: user.email
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            if response.result.isFailure {
                print("REQUEST FAILURE\(response.result.debugDescription)")
                completionHandler(false, nil)
                return
            }
            
            guard let json = response.result.value! as? Dictionary<String, AnyObject> else {
                print("BACKEND ERROR: PARSE ERROR")
                completionHandler(false, nil)
                return
            }
            guard let data = json["data"]! as? [Dictionary<String, AnyObject>] else {
                print("BACKEND ERROR: PARSE ERROR")
                completionHandler(false, nil)
                return
            }
            
            var postList: Array<Post> = []
            
            for postJSON in data {
                let id = postJSON["id"] as! Int
                let title = postJSON["title"] as! String
                let description = postJSON["description"] as! String
                let likes = postJSON["likes"] as! Int
                
                let post = Post(id: id, title: title, description: description, likes: likes)
                postList.append(post)
            }
            
            completionHandler(true, postList)
        }
    }
    
    //Helpers
    
//    private static func getPostURL() -> String {
//        let urlString : String = baseURL + "/posts"
//        return URL(urlString)
//    }
//    
//    private static func getSessionsURL() -> String {
//        let urlString : String = baseURL + "/sessions"
//        return URL(urlString)
//    }
}
