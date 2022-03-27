//
//  IGGalleryFactory.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

public class IGGalleryFactory {
    public static func gallery() -> IGGalleryController {
        let viewController = IGGalleryController()
        let presenter = IGGalleryPresenter()
        let interactor = IGGalleryInteractor()
        let routing = IGGalleryRouting()
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        
        routing.viewController = viewController
        interactor.output = presenter
        presenter.view = viewController
    
        return viewController
    }
}
