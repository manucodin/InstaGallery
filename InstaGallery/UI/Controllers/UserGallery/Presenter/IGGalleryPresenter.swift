//
//  IGPresenter.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

protocol IGPresenterDelegate: AnyObject{
    func imageDidSelect(image :IGImage)
    func userDidLogged(user :IGUser)
}

class IGGalleryPresenter: NSObject {
    
    weak var view :IGGalleryControllerInterface?
    
    internal var interactor: IGGalleryInteractorInput?
    internal var routing: IGGalleryRoutingInterface?
    
    override init() {}
    
    var isUserLogged: Bool {
        return IGManagerUtils.getUserToken() != nil
    }
    
    var hasNextPage: Bool {
        return interactor?.hasNextPage ?? false
    }
    
    var numberOfImages: Int {
        return interactor?.numberOfImages ?? 0
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
    }
    
    private func didSelectItem(atIndexPath indexPath: IndexPath) {
//        manager.getImage(withIdentifier: images[indexPath.row].identifier, withCompletionBlock: {[weak self] image in
//            if let strongSelf = self{
//                strongSelf.delegate?.imageDidSelect(image: image)
//            }
//        }, functionError: {error in
//            debugPrint(error.localizedDescription)
//        })
    }
}

extension IGGalleryPresenter: IGGalleryPresenterInterface {
    func viewLoaded() {
        view?.setupView()
        loadUserGallery()
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
}

extension IGGalleryPresenter: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(atIndexPath: indexPath)
    }
}

extension IGGalleryController :UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = collectionView.frame.size.width/3
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension IGGalleryPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = String(describing: IGGalleryCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! IGGalleryCell
        if let image = interactor?.image(atIndexPath: indexPath) {
            cell.setImage(image: image)
        }
    
        if hasNextPage && indexPath.row == numberOfImages - 1 {
            loadUserGallery()
        }
        
        return cell
    }

}
