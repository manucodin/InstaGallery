//
//  InstaGalleryError.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

enum InstaGalleryError: Error {
    case invalidUser
    case invalidRequest
    case invalidResponse
    case unexpected(code : Int)
}
