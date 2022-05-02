//
//  GalleryInteractorInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

protocol GalleryInteractorInput {
    var userName: String? { get }
    var isLoggedUser: Bool { get }
    
    func logoutUser()
    func loadUserGallery(nexPage: String?)
    func getImage(withImageCover imageCover: Media)
}

protocol GalleryInteractorOutput: AnyObject {
    func didLoadUserGallery(gallery: Gallery)
    func didSelect(media: Media)
}
