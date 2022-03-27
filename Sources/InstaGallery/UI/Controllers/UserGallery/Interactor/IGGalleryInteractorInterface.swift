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
    var userName: String? { get }
    var isLoggedUser: Bool { get }
    var numberOfMedias: Int { get }
    var hasNextPage: Bool { get }
    
    func logoutUser()
    func loadUserGallery()
    func imageCover(atIndexPath indexPath: IndexPath) -> IGMedia
    func getImage(withImageCover imageCover: IGMedia)
}

protocol IGGalleryInteractorOutput: AnyObject {
    func didLogoutUser()
    func didLoadUserGallery()
    func didSelect(media: IGMedia)
}
