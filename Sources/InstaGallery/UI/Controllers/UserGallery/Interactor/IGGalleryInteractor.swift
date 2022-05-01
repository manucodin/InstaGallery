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
    private let userDefaultsDataSource: IGUserDefaultsDataSourceInterface
    
    init(galleryDataSource: IGGalleryDataSource = IGGalleryDataSourceImp(),
         instagramDataSource: IGDataSourceInterface = IGDataSource(),
         userDefaultsDataSource: IGUserDefaultsDataSourceInterface = IGUserDefaultsDataSourceImp())
    {
        self.galleryDataSource = galleryDataSource
        self.instagramDataSource = instagramDataSource
        self.userDefaultsDataSource = userDefaultsDataSource
    }
}

extension IGGalleryInteractor: IGGalleryInteractorInput {
    var userName: String? {
        return userDefaultsDataSource.userName
    }
    
    var isLoggedUser: Bool {
        return userDefaultsDataSource.isUserLogged
    }
    
    var numberOfMedias: Int {
        return galleryDataSource.numberOfMedias
    }
    
    var hasNextPage: Bool {
        return galleryDataSource.hasNextPage
    }
    
    func logoutUser() {
        IGManagerUtils.logoutUser()
    }
    
    func loadUserGallery() {
        instagramDataSource.getUserGallery(withLastItem: galleryDataSource.nextPage) { [weak self] result in
            switch result {
            case .success(let galleryDTO):
                let gallery = IGGalleryMapper().transform(galleryDTO: galleryDTO)
                self?.galleryDataSource.updateGallery(gallery: gallery)
                self?.output?.didLoadUserGallery()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getImage(withImageCover imageCover: IGMedia) {
        instagramDataSource.getImage(withIdentifier: imageCover.identifier) { [weak self] result in
            switch result {
            case .success(let mediaDTO):
                if let mediaDTO = mediaDTO {
                    let media = IGMediaMapper().transform(dto: mediaDTO)
                    self?.output?.didSelect(media: media)
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func imageCover(atIndexPath indexPath: IndexPath) -> IGMedia {
        return galleryDataSource.media(atIndexPath: indexPath)
    }
}
