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
    
    let baseURL = "http://localhost:63342/Server/register.php"
    
    private init() {
        
    }
    
    
    func registerUser(username: String, password: String, email: String, fullname: String) {
        
        let parameterBundle = [
            "username" : username,
            "password" : password,
            "email" : email,
            "fullname" : fullname
        ]
        
        Alamofire.request(baseURL, method: .post, parameters: parameterBundle, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {
                response in
            
            print (response)
            
            
            
        })
        
    }

    
    
    
}
