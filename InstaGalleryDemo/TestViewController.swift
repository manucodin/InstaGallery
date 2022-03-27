//
//  TestViewController.swift
//  InstaGalleryDemo
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import UIKit
import InstaGallery

class TestViewController: UIViewController {
    
    @IBOutlet weak var sessionButton: IGSessionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func openGalleryPressed(_ sender: Any) {
        InstaGallery.openGallery(inViewController: self, withDelegate: self)
    }
}

extension TestViewController :IGGalleryDelegate{
    func didSelect(media: IGMedia) {
        print(media)
    }
}

