//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

internal struct IGUserDTOMother {
    internal static func user() -> IGUserDTO {
        return IGUserDTO(id: "1234", username: "testUser", urlAccount: "testAccount", token: "testToken")
    }
}
