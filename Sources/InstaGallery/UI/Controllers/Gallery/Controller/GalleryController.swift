//
//  GalleryController.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit

@objc public class GalleryController: UIViewController {
    
    @objc public weak var delegate :GalleryDelegate?
    
    internal var presenter :GalleryPresenterInterface?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = presenter?.galleryDataSource
        }
    }
    
    init(presenter: GalleryPresenterInterface = GalleryPresenter()) {
        #if SWIFT_PACKAGE
        super.init(nibName: String(describing: GalleryController.self), bundle: Bundle.module)
        #else
        super.init(nibName: String(describing: GalleryController.self), bundle: Bundle(for: GalleryController.self))
        #endif
        
        self.presenter = presenter
    }
    
    public required init?(coder: NSCoder) { return nil }
    
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
        guard let userName = presenter?.userName else { return }
        
        navigationItem.title = userName
    }
    
    private func configureCollectionView(){
        let cellIdentifier = String(describing: GalleryCell.self)
        
        var bundle: Bundle
        #if SWIFT_PACKAGE
        bundle = Bundle.module
        #else
        bundle = Bundle(for: GalleryCell.self)
        #endif
        
        
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    @objc private func dismissController(){
        presenter?.dismiss()
    }
}

extension GalleryController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectImage(atIndexPath: indexPath)
    }
}

extension GalleryController :UICollectionViewDelegateFlowLayout{
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

extension GalleryController: GalleryControllerInterface {
    func setupView() {
        configureNavigationBar()
        configureNavigationTitle()
        configureCollectionView()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func didSelect(media: Media) {
        delegate?.didSelect(media: media)
    }
}
