//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

internal struct IGPagingMother {
    internal static func paging() -> PagingDTO {
        return PagingDTO(cursors: IGCursorMother.cursor(), next: "nextPage")
    }
}
