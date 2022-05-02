//
//  GalleryInteractor.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

internal class GalleryInteractor {
    
    weak var output: GalleryInteractorOutput?
    
    private let instagramDataSource: InstagramDataSourceInterface
    private let userDefaultsDataSource: UserDataSourceInterface
    
    init(instagramDataSource: InstagramDataSourceInterface = InstagramDataSource(),
         userDefaultsDataSource: UserDataSourceInterface = UserDataSourceImp())
    {
        self.instagramDataSource = instagramDataSource
        self.userDefaultsDataSource = userDefaultsDataSource
    }
}

extension GalleryInteractor: GalleryInteractorInput {
    var userName: String? {
        return userDefaultsDataSource.userName
    }
    
    var isLoggedUser: Bool {
        return userDefaultsDataSource.isUserLogged
    }
    
    func logoutUser() {
        userDefaultsDataSource.clearAll()
    }
    
    func loadUserGallery(nexPage: String?) {
        instagramDataSource.getUserGallery(withLastItem: nexPage) { [weak self] result in
            switch result {
            case .success(let galleryDTO):
                let gallery = GalleryMapper().transform(galleryDTO: galleryDTO)
                self?.output?.didLoadUserGallery(gallery: gallery)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getImage(withImageCover imageCover: Media) {
        instagramDataSource.getImage(withIdentifier: imageCover.identifier) { [weak self] result in
            switch result {
            case .success(let mediaDTO):
                if let mediaDTO = mediaDTO {
                    let media = MediaMapper().transform(dto: mediaDTO)
                    self?.output?.didSelect(media: media)
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
