//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation

internal struct IGGalleryDTO: Codable {
    internal let data: [IGMediaDTO]?
    internal let paging: IGPagingDTO?
}
