//
//  IGAPIGraphURLProvider.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct IGAPIGraphURLProvider: IGURLBaseProvider {
    func tokenURL() -> URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent("access_token")
    }
    
    func refreshToken() -> URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent("refresh_access_token")
    }
    
    func userURL() -> URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent("me")
    }
    
    func mediaURL() -> URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent("me/media")
    }
    
    func mediaURL(withIdentifier identifier: String) -> URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent(identifier)
    }
}
