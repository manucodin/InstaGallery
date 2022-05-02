//
//  URLBaseProvider.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol URLBaseProvider {
    var API_INSTAGRAM: URL { get }
    var API_GRAPH_INSTRAGRAM: URL { get }
}

extension URLBaseProvider {
    var API_INSTAGRAM: URL {
        return URL(string: "https://api.instagram.com/")!
    }
    
    var API_GRAPH_INSTRAGRAM: URL {
        return URL(string: "https://graph.instagram.com/")!
    }
}
