//
//  IGConstants.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct IGConstants {
    internal struct BundleKeys {
        static let appIDKey = "InstagramClientId"
        static let redirectURIKey = "InstagramRedirectURI"
    }
    
    internal struct ParamsKeys {
        static let clientIDKey = "client_id"
        static let redirectURIKey = "redirect_uri"
        static let scopeKey = "scope"
        static let responseTypeKey = "response_type"
    }
}
