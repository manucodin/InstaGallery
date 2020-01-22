//
//  IGGalleryController.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit

@objc public class IGGalleryController: UIViewController {
    
    var presenter :IGPresenter!
    
    var completionBlock :((IGImage) -> Void)!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @objc public class func presentGalleryFrom(_ viewController:UIViewController, imageCompletion:@escaping((IGImage) -> Void)){
        let bundle = Bundle(for: IGGalleryController.self)
        let igGalleryController = IGGalleryController(nibName: "IGGalleryController", bundle: bundle)
        let navController = UINavigationController(rootViewController: igGalleryController)
        igGalleryController.configureCallback(functionCallback: imageCompletion)
        viewController.present(navController, animated: true, completion: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = IGPresenter(controller: self)
        
        configureView()
    }
    
    private func configureView(){
        configureNavigationBar()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        presenter.getUserGallery()
    }
    
    func setNavigationTitle(){
        if let userNick = IGManagerUtils.getUserName(){
            navigationItem.title = userNick
        }else{
            navigationItem.title = "Instagram"
        }
    }
    
    private func configureNavigationBar(){
        setNavigationTitle()
       
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func configureCallback(functionCallback :@escaping((IGImage) -> Void)){
        self.completionBlock = functionCallback
    }
    
    @objc private func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension IGGalleryController :UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

extension IGGalleryController :UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

extension IGGalleryController :UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
