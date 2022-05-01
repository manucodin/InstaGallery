//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation

enum IGError: Error {
    case invalidUser
    case invalidRequest
    case invalidResponse
    case unexpected(code : Int)
}
