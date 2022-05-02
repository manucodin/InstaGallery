//
//  CursorDTO.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//


import Foundation

internal struct CursorDTO: Codable {
    internal let after: String?
    internal let before: String?
}
