//
//  InstagramDataSourceInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol InstagramDataSourceInterface {    
    func getUserGallery(withLastItem lastItem: String?, completionHandler: @escaping ((Result<GalleryDTO, InstaGalleryError>) -> Void))
    func getImage(withIdentifier identifier: String, completionHandler: @escaping ((Result<MediaDTO?, InstaGalleryError>) -> Void))
    func authenticate(withUserCode userCode: String, completionHandler: @escaping ((Result<UserDTO, InstaGalleryError>) -> Void))
}
