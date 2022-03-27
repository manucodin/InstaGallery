//
//  IGUserDefaultsDataSourceImp.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGUserDefaultsDataSourceImp: IGUserDefaultsImp, IGUserDefaultsDataSourceInterface {
    var isUserLogged: Bool {
        return getUser()?.token != nil
    }
    
    internal func saveUser(user: IGUserDTO) {
        do {
            let userData = try JSONEncoder().encode(user)
            save(value: userData, withKey: IGConstants.UserDefaultsKeys.userKey)
        } catch let error {
            debugPrint(error)
        }
    }
    
    internal func getUser() -> IGUserDTO? {
        guard let userData = getData(withKey: IGConstants.UserDefaultsKeys.userKey) else { return nil }
        do {
            let user = try JSONDecoder().decode(IGUserDTO.self, from: userData)
            return user
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
}
