//
//  InstaGallery.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

@objc public class InstaGallery: NSObject {
    
    @objc public static func openGallery(inViewController viewController: UIViewController, withDelegate delegate: IGGalleryDelegate? = nil) {
        let galleryController = IGGalleryFactory.gallery()
        galleryController.delegate = delegate
        
        let navigationController = UINavigationController(rootViewController: galleryController)
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
