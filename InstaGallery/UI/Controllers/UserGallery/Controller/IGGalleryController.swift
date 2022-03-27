//
//  IGGalleryController.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit

@objc public class IGGalleryController: UIViewController {
    
    @objc public weak var delegate :IGGalleryDelegate?
    
    internal var presenter :IGGalleryPresenterInterface?
    
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

extension IGGalleryController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectImage(atIndexPath: indexPath)
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

extension IGGalleryController: IGGalleryControllerInterface {
    func setupView() {
        configureNavigationBar()
        configureNavigationTitle()
        configureCollectionView()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func didSelect(media: IGMedia) {
        delegate?.didSelect(media: media)
    }
}
