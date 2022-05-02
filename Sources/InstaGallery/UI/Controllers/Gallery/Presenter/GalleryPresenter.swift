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
    internal let notificationCenter = NotificationCenter.default
    
    var userName: String? {
        return interactor?.userName
    }
    
    var isUserLogged: Bool {
        return interactor?.isLoggedUser ?? false
    }
}

extension GalleryPresenter: GalleryPresenterInterface {
    func viewLoaded() {
        notificationCenter.addObserver(self, selector: .userLoggedOut, name: .invalidRefreshToken, object: nil)
        view?.setupView()
        loadUserGallery()
    }
    
    func selectImage(atIndexPath indexPath: IndexPath) {
        guard let imageCover = galleryDataSource?.media(atIndexPath: indexPath) else { return }
        interactor?.getImage(withImageCover: imageCover)
    }
    
    func dismiss() {
        notificationCenter.removeObserver(self)
        routing?.dismiss()
    }

    private func loadUserGallery() {
        guard isUserLogged else {
            showUserLogin()
            return
        }
        let nextPage = galleryDataSource?.nextPage
        interactor?.loadUserGallery(nexPage: nextPage)
    }
}

extension GalleryPresenter: GalleryInteractorOutput {
    func showUserLogin() {
        interactor?.logoutUser()
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
        dismiss()
    }
}

extension GalleryPresenter: GalleryDataSourceOutput {
    func loadNextPage() {
        self.loadUserGallery()
    }
}

extension GalleryPresenter {
    @objc func userLoggedOut(_ sender: AnyObject) {
        self.showUserLogin()
    }
}

fileprivate extension Selector {
    static let userLoggedOut = #selector(GalleryPresenter.userLoggedOut(_:))
}
