//
//  APIURLProvider.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct APIURLProvider: URLBaseProvider {
    var tokenURL: URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent("access_token")
    }
    
    var refreshToken: URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent("refresh_access_token")
    }
    
    var userURL: URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent("me")
    }
    
    var mediaURL: URL {
        return API_GRAPH_INSTRAGRAM.appendingPathComponent("me/media")
    }
}
