//
//  IGURLRequestProvider.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct IGAPIURLProvider: IGURLBaseProvider {
    func authorizeURL() -> URL {
        return API_INSTAGRAM.appendingPathComponent("oauth/authorize")
    }
    
    func authURL() -> URL {
        return API_INSTAGRAM.appendingPathComponent("oauth/access_token")
    }
}
