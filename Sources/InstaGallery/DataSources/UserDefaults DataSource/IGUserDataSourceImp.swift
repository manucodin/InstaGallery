//
//  IGUserDefaultsDataSourceImp.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGUserDataSourceImp: IGUserDefaultsImp, IGUserDataSourceInterface {
    
    private let bundleDataSource: IGBundleDataSourceInterface
    
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
    
    init(bundleDataSource: IGBundleDataSourceInterface = IGBundleDataSourceInterfaceImp()) {
        self.bundleDataSource = bundleDataSource
    }
    
    internal func saveUser(user: IGUserDTO) throws {
        do {
            let userData = try JSONEncoder().encode(user)
            save(value: userData, withKey: IGConstants.UserDefaultsKeys.userKey)
        }
    }
    
    internal func getUser() -> IGUserDTO? {
        guard let userData = getData(withKey: IGConstants.UserDefaultsKeys.userKey) else { return nil }
        do {
            let user = try? JSONDecoder().decode(IGUserDTO.self, from: userData)
            return user
        }
    }
    
    internal func clearAll() {
        removeValue(withKey: IGConstants.UserDefaultsKeys.userKey)
    }
}
