//
//  IGGalleryController.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit

@objc public protocol IGGalleryDelegate: AnyObject {
    @objc func didSelect(igImage :IGImage)
}

@objc public class IGGalleryController: UIViewController {
    
    var presenter :IGGalleryPresenterInterface?
        
    @objc public weak var delegate :IGGalleryDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = presenter
        }
    }
    
    init(presenter: IGGalleryPresenterInterface = IGGalleryPresenter()) {
        super.init(nibName: String(describing: IGGalleryController.self), bundle: Bundle(for: IGGalleryController.self))
        
        self.presenter = presenter
    }
    
    public required init?(coder: NSCoder) { return nil }
    
//    @objc public class func presentGalleryFrom(_ viewController:UIViewController){
//        let bundle = Bundle(for: IGGalleryController.self)
//        let igGalleryController = IGGalleryController(nibName: "IGGalleryController", bundle: bundle)
//        let navController = UINavigationController(rootViewController: igGalleryController)
//        viewController.present(navController, animated: true, completion: nil)
//    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewLoaded()
    }
    
    
    private func configureNavigationBar(){
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.title = "Instagram"
    }
    
    
    private func configureNavigationTitle(){
        guard let userNick = IGManagerUtils.getUserName() else { return }
        
        navigationItem.title = userNick
    }
    
    private func configureCollectionView(){
        let bundle = Bundle(for: IGGalleryCell.self)
        let cellIdentifier = String(describing: IGGalleryCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        
        collectionView.register(IGGalleryCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    @objc private func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension IGGalleryController :IGPresenterDelegate{
    func userDidLogged(user: IGUser) {
        navigationItem.title = user.account
    }
    
    func imageDidSelect(image: IGImage) {
        if let strongDelegate = self.delegate{
            strongDelegate.didSelect(igImage: image)
        }
    }
}

extension IGGalleryController: IGGalleryControllerInterface {
    func setupView() {
        configureNavigationBar()
        configureNavigationTitle()
        configureCollectionView()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
