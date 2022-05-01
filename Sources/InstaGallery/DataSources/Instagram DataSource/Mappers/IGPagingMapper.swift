//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation

internal class IGPagingMapper {
    internal func transform(pagingDTO: IGPagingDTO?) -> IGPaging? {
        guard let pagingDTO = pagingDTO else { return nil }
        
        let cursors = IGCursors(after: pagingDTO.cursors.after, before: pagingDTO.cursors.before)
        let next = pagingDTO.next
        return IGPaging(cursors: cursors, next: next)
    }
}
