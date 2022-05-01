//
//  IGGalleryDataSourceImp.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

internal class IGGalleryDataSourceImp {
    private var gallery = IGGallery()
}

extension IGGalleryDataSourceImp: IGGalleryDataSource {
    var hasNextPage: Bool {
        guard gallery.paging?.next != nil else {
            return false
        }
        
        return gallery.paging?.cursors?.after != nil
    }
    
    var nextPage: String? {
        return gallery.paging?.cursors?.after
    }
    
    var numberOfMedias: Int {
        return gallery.medias.count
    }
    
    func updateGallery(gallery: IGGallery) {
        self.gallery = self.gallery.updating(newMedias: gallery.medias).updating(paging: gallery.paging)
    }
    
    func media(atIndexPath indexPath: IndexPath) -> IGMedia {
        return gallery.medias[indexPath.row]
    }
}
