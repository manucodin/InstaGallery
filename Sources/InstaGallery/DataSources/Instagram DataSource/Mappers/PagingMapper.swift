//
//  PagingMapper.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class PagingMapper {
    internal func transform(pagingDTO: PagingDTO?) -> Paging? {
        guard let pagingDTO = pagingDTO else { return nil }
        
        let cursors = Cursors(after: pagingDTO.cursors.after, before: pagingDTO.cursors.before)
        let next = pagingDTO.next
        return Paging(cursors: cursors, next: next)
    }
}
