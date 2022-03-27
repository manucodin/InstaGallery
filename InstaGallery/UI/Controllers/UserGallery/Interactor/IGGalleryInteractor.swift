//
//  IGGalleryInteractor.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

internal class IGGalleryInteractor {
    
    weak var output: IGGalleryInteractorOutput?
    
    private let galleryDataSource: IGGalleryDataSource
    private let instagramDataSource: IGDataSourceInterface
    
    init(galleryDataSource: IGGalleryDataSource = IGGalleryDataSourceImp(), instagramDataSource: IGDataSourceInterface = IGDataSource()) {
        self.galleryDataSource = galleryDataSource
        self.instagramDataSource = instagramDataSource
    }
}

extension IGGalleryInteractor: IGGalleryInteractorInput {
    
    var numberOfImages: Int {
        return galleryDataSource.numberOfImages
    }
    
    var hasNextPage: Bool {
        return galleryDataSource.hasNextPage
    }
    
    func logoutUser() {
        IGManagerUtils.logoutUser()
    }
    
    func loadUserGallery() {
        instagramDataSource.getUserGallery(withLastItem: galleryDataSource.nextPage, withCompletionBlock: { [weak self] images, nextPage in
            self?.galleryDataSource.updateNextPage(newNextPage: nextPage)
            self?.galleryDataSource.addImages(newImages: images)
            self?.output?.didLoadUserGallery()
        }, errorBlock: { [weak self] error in
            debugPrint(error)
        })
    }
    
    func image(atIndexPath indexPath: IndexPath) -> IGImageCover {
        return galleryDataSource.image(atIndexPath: indexPath)
    }
}
