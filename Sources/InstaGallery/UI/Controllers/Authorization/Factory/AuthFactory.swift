//
//  AuthFactory.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class AuthFactory {
    
    internal static func auth(completionCallback: @escaping (() -> Void)) -> AuthController {
        let viewController = AuthController()
        let presenter = AuthPresenter()
        let routing = AuthRouting()
        let interactor = AuthInteractor()
        
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
