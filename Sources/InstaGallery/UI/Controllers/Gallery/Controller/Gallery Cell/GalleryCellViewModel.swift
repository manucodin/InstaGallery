//
//  GalleryCellViewModel.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct GalleryCellViewModel {
    internal let mediaThumbnailURL: URL?
    
    init(media: Media) {
        self.mediaThumbnailURL = media.mediaType == .video ? media.thumbanailURL : media.url
    }
}
