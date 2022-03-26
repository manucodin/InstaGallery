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

class IGPresenter{
    
    private let cellIdentifier = "IGGalleryCell"

    let manager = IGDataSource()
    
    var images = [IGImageCover]()
    var nextPage :String?
    
    weak var delegate   :IGPresenterDelegate?
    weak var controller :IGGalleryController?
    
    init(controller :IGGalleryController){
        self.controller = controller
        registerCell()
    }
    
    private func registerCell(){
//        let bundle = Bundle(for: IGGalleryCell.self)
//        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
//        
//        controller?.collectionView.register(IGGalleryCell.self, forCellWithReuseIdentifier: cellIdentifier)
//        controller?.collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func getUserGallery(withLastItem lastItem:String? = nil){
        if(IGManagerUtils.getUserToken() == nil){
            self.loginUser()
            return
        }
        
        manager.getUserGallery(withLastItem: lastItem, withCompletionBlock: {[weak self] images, nextItem in
            if let strongSelf = self, let nextImages = images{
                strongSelf.images.append(contentsOf: nextImages)
                strongSelf.nextPage = nextItem
                strongSelf.controller?.collectionView.reloadData()
            }
        }, errorBlock: {error in
            self.loginUser()
        })
    }
    
    private func loginUser(){
        IGManagerUtils.logoutUser()
        
        let authController = IGAuthFactory.controller(completionCallback: { [weak self] user in
            guard let welf = self else { return }
            
            welf.getUserGallery()
            welf.delegate?.userDidLogged(user: user)
        })
        
        let navigationController = UINavigationController(rootViewController: authController)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        self.controller?.present(navigationController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! IGGalleryCell
        cell.setImage(image: images[indexPath.row])
        
        if let nextItem = nextPage, indexPath.row == images.count-1{
            self.getUserGallery(withLastItem: nextItem)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        manager.getImage(withIdentifier: images[indexPath.row].identifier, withCompletionBlock: {[weak self] image in
            if let strongSelf = self{
                strongSelf.delegate?.imageDidSelect(image: image)
            }
        }, functionError: {error in
            debugPrint(error.localizedDescription)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = collectionView.frame.size.width/3
        return CGSize(width: width, height: width)
    }
}
