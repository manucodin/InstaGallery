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
        instagramDataSource.getUserGallery(withLastItem: galleryDataSource.nextPage, withCompletionBlock: { [weak self] newMediasDTO, nextPage in
            let newMedias = newMediasDTO.map({ IGMediaMapper.transform(dto: $0) })
            self?.galleryDataSource.updateNextPage(newNextPage: nextPage)
            self?.galleryDataSource.addMedias(newMedias: newMedias)
            self?.output?.didLoadUserGallery()
        }, errorBlock: { _ in })
    }
    
    func getImage(withImageCover imageCover: IGMedia) {
        instagramDataSource.getImage(withIdentifier: imageCover.identifier, withCompletionBlock: { [weak self] mediaDTO in
            let media = IGMediaMapper.transform(dto: mediaDTO)
            self?.output?.didSelect(media: media)
        }, functionError: { _ in })
    }
    
    func imageCover(atIndexPath indexPath: IndexPath) -> IGMedia {
        return galleryDataSource.media(atIndexPath: indexPath)
    }
}
