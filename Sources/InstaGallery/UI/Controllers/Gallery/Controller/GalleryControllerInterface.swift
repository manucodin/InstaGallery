//
//  GalleryControllerInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

@objc public protocol GalleryDelegate: AnyObject {
    @objc func didSelect(media :Media)
}

internal protocol GalleryControllerInterface: AnyObject {
    func setupView()
    func reloadData()
    func didSelect(media: Media)
}
