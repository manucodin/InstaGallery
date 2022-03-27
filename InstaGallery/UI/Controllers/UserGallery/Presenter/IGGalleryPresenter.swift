//
//  IGPresenter.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

class IGGalleryPresenter: NSObject {
    
    weak var view :IGGalleryControllerInterface?
    
    internal var interactor: IGGalleryInteractorInput?
    internal var routing: IGGalleryRoutingInterface?
    
    override init() {}
    
    var isUserLogged: Bool {
        return interactor?.isLoggedUser ?? false
    }
    
    var hasNextPage: Bool {
        return interactor?.hasNextPage ?? false
    }
    
    var numberOfMedias: Int {
        return interactor?.numberOfMedias ?? 0
    }
    
    private func loadUserGallery(){
        guard isUserLogged else {
            loginUser()
            return
        }
        
        interactor?.loadUserGallery()
    }
    
    private func loginUser(){
        interactor?.logoutUser()
        routing?.presentLoginUser { [weak self] in
            self?.loadUserGallery()
        }
    }
}

extension IGGalleryPresenter: IGGalleryPresenterInterface {
    func viewLoaded() {
        view?.setupView()
        loadUserGallery()
    }
    
    func selectImage(atIndexPath indexPath: IndexPath) {
        guard let imageCover = interactor?.imageCover(atIndexPath: indexPath) else { return }
        
        interactor?.getImage(withImageCover: imageCover)
    }
}

extension IGGalleryPresenter: IGGalleryInteractorOutput {
    func didLogoutUser() {
        routing?.presentLoginUser { [weak self] in
            guard let welf = self else { return }
            
            welf.loadUserGallery()
        }
    }
    
    func didLoadUserGallery() {
        view?.reloadData()
    }
    
    func didSelect(media: IGMedia) {
        view?.didSelect(media: media)
    }
}

extension IGGalleryPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfMedias
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = String(describing: IGGalleryCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! IGGalleryCell
        if let image = interactor?.imageCover(atIndexPath: indexPath) {
            cell.setImage(media: image)
        }
    
        if hasNextPage && indexPath.row == numberOfMedias - 1 {
            loadUserGallery()
        }
        
        return cell
    }

}
