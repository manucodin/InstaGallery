//
//  IGRequestConstants.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct IGRequestConstants {
    internal static let baseURL = URL(string: "https://api.instagram.com")!
    internal static let authorizationURL = IGRequestConstants.baseURL.appendingPathComponent("oauth/authorize")
}
