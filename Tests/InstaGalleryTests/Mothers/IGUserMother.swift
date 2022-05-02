//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

internal struct IGUserMother {
    internal static func user() -> User {
        return User(identifier: "testIdentifier", account: "testAccount", urlAccount: "testAccount", token: "testToken")
    }
}
