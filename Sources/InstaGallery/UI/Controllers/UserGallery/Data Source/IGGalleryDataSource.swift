//
//  IGGalleryDataSource.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

internal protocol IGGalleryDataSource {
    var hasNextPage: Bool { get }
    var nextPage: String? { get }
    var numberOfMedias: Int { get }
    
    func updateNextPage(newNextPage: String?)
    func addMedias(newMedias: [IGMedia])
    func media(atIndexPath indexPath: IndexPath) -> IGMedia
}
