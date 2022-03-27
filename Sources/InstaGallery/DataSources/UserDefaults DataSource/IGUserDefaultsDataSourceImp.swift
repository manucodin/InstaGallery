//
//  IGUserDefaultsDataSourceImp.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGUserDefaultsDataSourceImp: IGUserDefaultsImp, IGUserDefaultsDataSourceInterface {
    var userName: String? {
        if let userData = getUser() {
            return userData.username
        }
        
        if let userName = getValue(withKey: IGConstants.UserDefaultsKeys.IG_USER_NAME) as? String {
            return userName
        }
        
        return nil
    }
    
    var userToken: String? {
        if let userData = getUser() {
            return userData.token
        }
        
        if let userName = getValue(withKey: IGConstants.UserDefaultsKeys.IG_TOKEN_KEY) as? String {
            return userName
        }
        
        return nil
    }
    
    var isUserLogged: Bool {
        return getUser()?.token != nil
    }
    
    func saveUser(user: IGUserDTO) {
        do {
            let userData = try JSONEncoder().encode(user)
            save(value: userData, withKey: IGConstants.UserDefaultsKeys.userKey)
        } catch let error {
            debugPrint(error)
        }
    }
    
    func getUser() -> IGUserDTO? {
        guard let userData = getData(withKey: IGConstants.UserDefaultsKeys.userKey) else { return nil }
        do {
            let user = try JSONDecoder().decode(IGUserDTO.self, from: userData)
            return user
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    func clearAll() {
        removeValue(withKey: IGConstants.UserDefaultsKeys.IG_TOKEN_KEY)
        removeValue(withKey: IGConstants.UserDefaultsKeys.IG_USERID_KEY)
        removeValue(withKey: IGConstants.UserDefaultsKeys.IG_USER_NAME)
        removeValue(withKey: IGConstants.UserDefaultsKeys.userKey)
    }
}
