//
//  Post.swift
//  SceneIt
//
//  Created by Jasdip Chauhan on 2017-09-02.
//  Copyright © 2017 Jasdip Chauhan. All rights reserved.
//

import Foundation

public class Post {
    
    var id: Int
    var title: String
    var description: String
    var likes: Int
    
    public init(id: Int, title: String, description: String, likes: Int = 0) {
        self.id = id
        self.title = title
        self.description = description
        self.likes = likes
    }
}
