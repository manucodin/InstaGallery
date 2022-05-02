//
//  ViewController.swift
//  InstaGalleryDemo
//
//  Created by Manuel Rodriguez on 28/3/22.
//

import UIKit
import InstaGallery

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let galleryController = InstaGallery.gallery(withDelegate: self)
        let navigationController = UINavigationController(rootViewController: galleryController)
        present(navigationController, animated: true, completion: nil)
    }
}

extension ViewController: GalleryDelegate {
    func didSelect(media: Media) {
        debugPrint(media)
    }
}

