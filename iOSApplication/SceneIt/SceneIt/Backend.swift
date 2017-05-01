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
    
    let baseURL = "http://192.168.0.15/SceneIt%20Server/register.php"
    
    private init() {
        
    }
    
    
    func registerUser(username: String, password: String, email: String, fullname: String) {
        
        guard let requestUrl = URL(string: baseURL) else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let body = "username=\(username)&password=\(password)&email=\(email)&fullname=\(fullname)"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print ("Error")
                return
            }
            
            //callback to UI thread
            DispatchQueue.main.async( execute: {
    
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parsedJson = json else {
                        print ("Error while parsing")
                        return
                    }
                    
                    print(parsedJson)
                    
                    
                } catch {
                    print ("BACKEND (register user): caught an error\(error)")
                }
                
            })
            
            
        }).resume()
    
        
    }
}
