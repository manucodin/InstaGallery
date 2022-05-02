//
//  Gallery.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//


import Foundation

internal struct Gallery {
    internal let medias: [Media]
    internal let paging: Paging?
    
    init(medias: [Media] = [], paging: Paging? = nil) {
        self.medias = medias
        self.paging = paging
    }
    
    internal func updating(newMedias: [Media]) -> Gallery {
        var oldMedias = medias
        oldMedias.append(contentsOf: newMedias)
        return Gallery(medias: oldMedias, paging: paging)
    }
    
    internal func updating(paging: Paging?) -> Gallery {
        return Gallery(medias: medias, paging: paging)
    }
}
