//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

internal struct IGUserMother {
    internal static func user() -> IGUser {
        return IGUser(identifier: "testIdentifier", account: "testAccount", urlAccount: "testAccount", token: "testToken")
    }
}
