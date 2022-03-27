//
//  IGGalleryRouting.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

internal class IGGalleryRouting {
    weak var viewController: UIViewController?
}

extension IGGalleryRouting: IGGalleryRoutingInterface {
    func presentLoginUser(completionCallback: @escaping (() -> Void)) {
        let authController = IGAuthFactory.auth(completionCallback: completionCallback)
        let navigationController = UINavigationController(rootViewController: authController)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        viewController?.present(navigationController, animated: true, completion: nil)
    }
}
