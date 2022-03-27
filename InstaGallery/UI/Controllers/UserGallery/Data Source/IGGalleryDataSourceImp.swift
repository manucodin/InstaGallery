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
    private var images = [IGImageCover]()
}

extension IGGalleryDataSourceImp: IGGalleryDataSource {
    var hasNextPage: Bool {
        return nextPage == nil
    }
    
    var numberOfImages: Int {
        return images.count
    }
    
    func updateNextPage(newNextPage: String?) {
        self.nextPage = newNextPage
    }
    
    func addImages(newImages: [IGImageCover]) {
        images.append(contentsOf: newImages)
    }
    
    func image(atIndexPath indexPath: IndexPath) -> IGImageCover {
        return images[indexPath.row]
    }
}
