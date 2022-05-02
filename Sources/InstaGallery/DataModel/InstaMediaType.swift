//
//  IGMediaType.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

@objc public enum InstaMediaType: Int {
    case image
    case video
    case carousel
    case unknow
    
    init(dto: MediaTypeDTO?) {
        guard let dto = dto else {
            self = .unknow
            return
        }
        
        switch dto {
        case .IMAGE: self = .image
        case .VIDEO: self = .video
        case .CAROUSEL_ALBUM: self = .carousel
        }
    }
}
