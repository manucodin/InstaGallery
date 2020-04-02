//
//  ViewController.swift
//  InstaGalleryDemo
//
//  Created by Manuel Rodríguez Sebastián on 29/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit
import InstaGallery

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showGallery()
    }
    
    private func showGallery(){
        let galleryController = IGGalleryController()
        galleryController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: galleryController)
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension ViewController :IGGalleryDelegate{
    func didSelect(igImage: IGImage) {
        print(igImage)
    }
}

