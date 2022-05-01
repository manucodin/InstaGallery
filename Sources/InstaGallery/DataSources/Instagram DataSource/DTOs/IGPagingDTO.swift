//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation

internal struct IGPagingDTO: Codable {
    internal let cursors: IGCursorDTO
    internal let next: String?
}
