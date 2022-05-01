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
        case id
        case username
        case urlAccount
        case token = "access_token"
    }
    
    init(id: String? = nil, username: String? = nil, urlAccount: String? = nil, token: String? = nil) {
        self.id = id
        self.username = username
        self.urlAccount = urlAccount
        self.token = token
    }
    
    internal func updating(token: String?) -> IGUserDTO {
        return IGUserDTO(id: id, username: username, urlAccount: urlAccount, token: token)
    }
}
