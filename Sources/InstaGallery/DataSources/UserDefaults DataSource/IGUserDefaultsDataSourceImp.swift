//
//  IGUserDefaultsDataSourceImp.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGUserDefaultsDataSourceImp: IGUserDefaultsImp, IGUserDefaultsDataSourceInterface {
    var userID: String? {
        if let userData = getUser() {
            return userData.id
        }
        
        return nil
    }
    
    var userName: String? {
        if let userData = getUser() {
            return userData.username
        }
        
        return nil
    }
    
    var userToken: String? {
        if let userData = getUser() {
            return userData.token
        }
        
        return nil
    }
    
    var isUserLogged: Bool {
        return getUser()?.token != nil
    }
    
    func saveUser(user: IGUserDTO) throws {
        do {
            let userData = try JSONEncoder().encode(user)
            save(value: userData, withKey: IGConstants.UserDefaultsKeys.userKey)
        }
    }
    
    func getUser() -> IGUserDTO? {
        guard let userData = getData(withKey: IGConstants.UserDefaultsKeys.userKey) else { return nil }
        do {
            let user = try? JSONDecoder().decode(IGUserDTO.self, from: userData)
            return user
        }
    }
    
    func clearAll() {
        removeValue(withKey: IGConstants.UserDefaultsKeys.userKey)
    }
}
