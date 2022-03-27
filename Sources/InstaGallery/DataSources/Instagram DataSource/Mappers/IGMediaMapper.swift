//
//  IGMediaMapper.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGMediaMapper {
    
    internal static func transform(dto: IGMediaDTO) -> IGMedia {
        return IGMedia(
            caption: dto.caption,
            identifier: dto.id ?? "",
            mediaType: IGMediaType(dto: dto.mediaType),
            url: URL(string: dto.mediaURL ?? ""),
            permalink: URL(string: dto.permalink ?? ""),
            thumbnailURL: URL(string: dto.thumbnailURL ?? ""),
            date: dto.timestamp?.date(),
            username: dto.username ?? "")
    }
}
