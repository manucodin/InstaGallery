//
//  GalleryCell.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    
    var viewModel: GalleryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            setup(viewModel)
        }
    }
    
    private func setup(_ viewModel: GalleryCellViewModel) {
        if let thumbnailURL = viewModel.mediaThumbnailURL {
            userImage.imageFromURL(url: thumbnailURL)
        }
    }
}
