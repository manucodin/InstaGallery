//
//  IGConstants.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct IGConstants {
    internal struct UserDefaultsKeys {
        static let userKey = "InstagramUser"
    }
    
    internal struct BundleKeys {
        static let appIDKey = "InstagramClientId"
        static let clientSecretKey = "InstagramClientSecret"
        static let redirectURIKey = "InstagramRedirectURI"
    }
    
    internal struct ParamsKeys {
        static let accessTokenKey = "access_token"
        static let clientIDKey = "client_id"
        static let redirectURIKey = "redirect_uri"
        static let scopeKey = "scope"
        static let responseTypeKey = "response_type"
    }
}
