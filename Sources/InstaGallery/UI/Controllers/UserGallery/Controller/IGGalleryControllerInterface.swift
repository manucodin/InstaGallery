//
//  IGGalleryControllerInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

@objc public protocol IGGalleryDelegate: AnyObject {
    @objc func didSelect(media :IGMedia)
}

internal protocol IGGalleryControllerInterface: AnyObject {
    func setupView()
    func reloadData()
    func didSelect(media: IGMedia)
}