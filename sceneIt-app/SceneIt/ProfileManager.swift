//
//  ProfileManager.swift
//  SceneIt
//
//  Created by Jasdip Chauhan on 2017-09-01.
//  Copyright © 2017 Jasdip Chauhan. All rights reserved.
//

import Foundation

public class ProfileManager {
    
    private static var profileManager: ProfileManager? = nil
    
    public static func getProfileManager() -> ProfileManager {
        if (profileManager == nil) {
            profileManager = ProfileManager()
        }
        
        return profileManager!
    }
    
    private var currentUser: User?
    
    //PUBLIC METHODS
    
    public func setCurrentUser(id: Int, email: String, apiToken: String) {
        currentUser = User(id: id, email: email, apiToken: apiToken)
    }
    
    public func getCurrentUser() -> User? {
        return currentUser
    }
    
    
    //PRIVATE METHODS
    
    private init() {}
    
    private func isUserValid () -> Bool {
        guard let user = self.currentUser else {
            return false
        }
        
        return user.apiToken != nil && user.email != nil && user.id != nil
    }
}
