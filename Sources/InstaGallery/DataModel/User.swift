//
//  User.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 26/02/2020.
//  Copyright © 2020 MRodriguez. All rights reserved.
//

import Foundation

public struct User {
    public var identifier :String
    public var account :String
    public var urlAccount :String
    public var token: String?
    
    public func updating(token: String) -> User {
        return User(identifier: identifier, account: account, urlAccount: urlAccount, token: token)
    }
}
