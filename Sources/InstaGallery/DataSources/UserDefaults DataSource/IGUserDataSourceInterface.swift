//
//  IGUserDefaultsDataSourceInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol IGUserDataSourceInterface: IGUserDefaultsInterface {
    var userID: String? { get }
    var userName: String? { get }
    var userToken: String? { get }
    var isUserLogged: Bool { get }
    
    func saveUser(user: IGUserDTO) throws
    func getUser() -> IGUserDTO?
    func clearAll()
}
