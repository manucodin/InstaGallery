//
//  UserMapper.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class UserMapper {
    internal func transform(dto: UserDTO) -> User {
        return User(
            identifier: dto.id ?? "",
            account: dto.username ?? "",
            urlAccount: dto.urlAccount ?? "",
            token: dto.token ?? ""
        )
    }
    
    internal func transform(model: User) -> UserDTO {
        return UserDTO(
            id: model.identifier,
            username: model.account,
            urlAccount: model.urlAccount,
            token: model.token
        )
    }
}
