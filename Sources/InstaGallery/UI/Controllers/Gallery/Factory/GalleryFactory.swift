//
//  GalleryFactory.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

public class GalleryFactory {
    public static func gallery() -> GalleryController {
        let viewController = GalleryController()
        let galleryDataSource = GalleryDataSourceImp()
        let presenter = GalleryPresenter()
        let interactor = GalleryInteractor()
        let routing = GalleryRouting()
        
        viewController.presenter = presenter
        galleryDataSource.output = presenter
        
        presenter.interactor = interactor
        presenter.routing = routing
        presenter.galleryDataSource = galleryDataSource
        
        routing.viewController = viewController
        interactor.output = presenter
        presenter.view = viewController
    
        
        
        return viewController
    }
}
