//
//  UserDataSourceImp.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class UserDataSourceImp: UserDefaultsImp, UserDataSourceInterface {
    
    private let bundleDataSource: BundleDataSourceInterface
    
    internal var userID: String? {
        return getUser()?.id
    }
    
    internal var userName: String? {
        return getUser()?.username
    }
    
    internal var userToken: String? {
        return getUser()?.token
    }
    
    internal var isUserLogged: Bool {
        return getUser()?.token != nil
    }
    
    init(bundleDataSource: BundleDataSourceInterface = BundleDataSourceInterfaceImp()) {
        self.bundleDataSource = bundleDataSource
    }
    
    internal func saveUser(user: UserDTO) throws {
        do {
            let userData = try JSONEncoder().encode(user)
            save(value: userData, withKey: Constants.UserDefaultsKeys.userKey)
        }
    }
    
    internal func getUser() -> UserDTO? {
        guard let userData = getData(withKey: Constants.UserDefaultsKeys.userKey) else { return nil }
        do {
            let user = try? JSONDecoder().decode(UserDTO.self, from: userData)
            return user
        }
    }
    
    internal func clearAll() {
        removeValue(withKey: Constants.UserDefaultsKeys.userKey)
        ManagerUtils.logoutUser()
    }
}
