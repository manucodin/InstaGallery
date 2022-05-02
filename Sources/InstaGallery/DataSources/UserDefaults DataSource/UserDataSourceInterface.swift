//
//  UserDataSourceInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol UserDataSourceInterface: UserDefaultsInterface {
    var userID: String? { get }
    var userName: String? { get }
    var userToken: String? { get }
    var isUserLogged: Bool { get }
    
    func saveUser(user: UserDTO) throws
    func getUser() -> UserDTO?
    func clearAll()
}
