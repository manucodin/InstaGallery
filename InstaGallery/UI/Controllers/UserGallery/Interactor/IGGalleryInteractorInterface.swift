//
//  IGGalleryInteractorInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

protocol IGGalleryInteractorInput {
    var numberOfImages: Int { get }
    var hasNextPage: Bool { get }
    
    func logoutUser()
    func loadUserGallery()
    func image(atIndexPath indexPath: IndexPath) -> IGImageCover
}

protocol IGGalleryInteractorOutput: AnyObject {
    func didLogoutUser()
    func didLoadUserGallery()
}
