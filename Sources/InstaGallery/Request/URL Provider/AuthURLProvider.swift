//
//  AuthURLProvider.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct AuthURLProvider: URLBaseProvider {
    var authorizeURL: URL {
        return API_INSTAGRAM.appendingPathComponent("oauth/authorize")
    }
    
    var authURL: URL {
        return API_INSTAGRAM.appendingPathComponent("oauth/access_token")
    }
}
