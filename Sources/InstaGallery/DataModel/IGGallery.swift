//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation

internal struct IGGallery {
    internal let medias: [IGMedia]
    internal let paging: IGPaging?
    
    init(medias: [IGMedia] = [], paging: IGPaging? = nil) {
        self.medias = medias
        self.paging = paging
    }
    
    internal func updating(newMedias: [IGMedia]) -> IGGallery {
        var oldMedias = medias
        oldMedias.append(contentsOf: newMedias)
        return IGGallery(medias: oldMedias, paging: paging)
    }
    
    internal func updating(paging: IGPaging?) -> IGGallery {
        return IGGallery(medias: medias, paging: paging)
    }
}
