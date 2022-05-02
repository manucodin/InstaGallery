//
//  GalleryMapper.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class GalleryMapper {
    
    private let mediaMapper = MediaMapper()
    private let pagingMapper = PagingMapper()
    
    func transform(galleryDTO: GalleryDTO) -> Gallery {
        let medias = galleryDTO.data?.filter{ $0.mediaType == .IMAGE }.compactMap{ mediaMapper.transform(dto: $0) } ?? []
        let paging = pagingMapper.transform(pagingDTO: galleryDTO.paging)
        return Gallery(medias: medias, paging: paging)
    }
}
