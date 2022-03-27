//
//  IGUserDTO.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct IGUserDTO: Codable {
    internal let id :String?
    internal let username :String?
    internal let urlAccount :String?
    internal let token: String?
    
    private enum CodingKeys :String, CodingKey{
        case id = "user_id"
        case username
        case urlAccount
        case token = "access_token"
    }
    
    internal func updating(token: String?) -> IGUserDTO {
        return IGUserDTO(id: id, username: username, urlAccount: urlAccount, token: token)
    }
}
