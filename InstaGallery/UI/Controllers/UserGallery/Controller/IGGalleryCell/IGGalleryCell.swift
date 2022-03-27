//
//  IGGalleryCell.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit

class IGGalleryCell: UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(media :IGMedia){
        guard let urlImage = media.url else { return }
        
        userImage.imageFromURL(url: urlImage)
    }
}
