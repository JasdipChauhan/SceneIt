//
//  User.swift
//  SceneIt
//
//  Created by Jasdip Chauhan on 2017-09-02.
//  Copyright © 2017 Jasdip Chauhan. All rights reserved.
//

import Foundation

public class User {
    
    var id: Int
    var email: String
    var apiToken: String
    
    public init(id: Int, email: String, apiToken: String) {
        self.id = id
        self.email = email
        self.apiToken = apiToken
    }
    
}
