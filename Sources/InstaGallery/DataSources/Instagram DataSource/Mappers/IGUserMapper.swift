//
//  IGUserMapper.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGUserMapper {
    
    internal static func transform(dto: IGUserDTO) -> IGUser {
        return IGUser(
            identifier: dto.id ?? "",
            account: dto.username ?? "",
            urlAccount: dto.urlAccount ?? "",
            token: dto.token ?? ""
        )
    }
    
    internal static func transform(model: IGUser) -> IGUserDTO {
        return IGUserDTO(
            id: model.identifier,
            username: model.account,
            urlAccount: model.urlAccount,
            token: model.token
        )
    }
}
