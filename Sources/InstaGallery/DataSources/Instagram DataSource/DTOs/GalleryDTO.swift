//
//  GalleryDTO.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct GalleryDTO: Codable {
    internal let data: [MediaDTO]?
    internal let paging: PagingDTO?
}
