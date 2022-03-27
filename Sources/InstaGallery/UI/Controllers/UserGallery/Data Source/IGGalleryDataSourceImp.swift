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
    internal var nextPage: String?
    private var medias = [IGMedia]()
}

extension IGGalleryDataSourceImp: IGGalleryDataSource {
    var hasNextPage: Bool {
        return nextPage == nil
    }
    
    var numberOfMedias: Int {
        return medias.count
    }
    
    func updateNextPage(newNextPage: String?) {
        self.nextPage = newNextPage
    }
    
    func addMedias(newMedias: [IGMedia]) {
        medias.append(contentsOf: newMedias)
    }
    
    func media(atIndexPath indexPath: IndexPath) -> IGMedia {
        return medias[indexPath.row]
    }
}
