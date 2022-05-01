//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation

internal class IGGalleryMapper {
    
    private let mediaMapper = IGMediaMapper()
    private let pagingMapper = IGPagingMapper()
    
    func transform(galleryDTO: IGGalleryDTO) -> IGGallery {
        let medias = galleryDTO.data?.filter{ $0.mediaType == .IMAGE }.compactMap{ mediaMapper.transform(dto: $0) } ?? []
        let paging = pagingMapper.transform(pagingDTO: galleryDTO.paging)
        return IGGallery(medias: medias, paging: paging)
    }
}
