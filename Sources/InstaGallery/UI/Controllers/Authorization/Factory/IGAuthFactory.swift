//
//  IGAuthFactory.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGAuthFactory {
    
    internal static func auth(completionCallback: @escaping (() -> Void)) -> IGAuthController {
        let viewController = IGAuthController()
        let presenter = IGAuthPresenter()
        let routing = IGAuthRouting()
        let interactor = IGAuthInteractor()
        
        viewController.completionCallback = completionCallback
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        
        interactor.output = presenter
        presenter.view = viewController
        
        routing.view = viewController
        
        return viewController
    }
    
}
