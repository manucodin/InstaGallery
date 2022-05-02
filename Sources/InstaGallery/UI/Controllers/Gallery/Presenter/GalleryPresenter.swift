//
//  GalleryPresenter.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

class GalleryPresenter {
    
    weak var view :GalleryControllerInterface?
    
    internal var interactor: GalleryInteractorInput?
    internal var routing: GalleryRoutingInterface?
    internal var galleryDataSource: GalleryDataSource?
    
    var userName: String? {
        return interactor?.userName
    }
    
    var isUserLogged: Bool {
        return interactor?.isLoggedUser ?? false
    }
}

extension GalleryPresenter: GalleryPresenterInterface {
    func viewLoaded() {
        view?.setupView()
        loadUserGallery()
    }
    
    func selectImage(atIndexPath indexPath: IndexPath) {
        guard let imageCover = galleryDataSource?.media(atIndexPath: indexPath) else { return }
        interactor?.getImage(withImageCover: imageCover)
    }

    private func loginUser(){
        interactor?.logoutUser()
        routing?.presentLoginUser {
            self.loadUserGallery()
        }
    }
    
    private func loadUserGallery() {
        let nextPage = galleryDataSource?.nextPage
        interactor?.loadUserGallery(nexPage: nextPage)
    }
}

extension GalleryPresenter: GalleryInteractorOutput {
    func showUserLogin() {
        routing?.presentLoginUser {
            self.loadUserGallery()
        }
    }
    
    func didLoadUserGallery(gallery: Gallery) {
        galleryDataSource?.updateGallery(gallery: gallery)
        view?.reloadData()
    }
    
    func didSelect(media: Media) {
        view?.didSelect(media: media)
        routing?.dismiss()
    }
}

extension GalleryPresenter: GalleryDataSourceOutput {
    func loadNextPage() {
        self.loadUserGallery()
    }
}
