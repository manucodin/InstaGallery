//
//  GalleryDataSourceImp.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

internal class GalleryDataSourceImp: NSObject {
    weak var output: GalleryDataSourceOutput?
    private var gallery = Gallery()
}

extension GalleryDataSourceImp: GalleryDataSource {
    var hasNextPage: Bool {
        guard gallery.paging?.next != nil else {
            return false
        }
        
        return gallery.paging?.cursors?.after != nil
    }
    
    var nextPage: String? {
        return gallery.paging?.cursors?.after
    }
    
    var numberOfMedias: Int {
        return gallery.medias.count
    }
    
    func updateGallery(gallery: Gallery) {
        self.gallery = self.gallery.updating(newMedias: gallery.medias).updating(paging: gallery.paging)
    }
    
    func media(atIndexPath indexPath: IndexPath) -> Media {
        return gallery.medias[indexPath.row]
    }
}

extension GalleryDataSourceImp: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfMedias
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = String(describing: GalleryCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GalleryCell
        let media = gallery.medias[indexPath.row]
        cell.viewModel = GalleryCellViewModel(media: media)
        
        if hasNextPage && indexPath.row == numberOfMedias - 1 {
            output?.loadNextPage()
        }
        
        return cell
    }
}

