//
//  MediaMapper.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class MediaMapper {
    internal func transform(dto: MediaDTO) -> Media {
        return Media(
            caption: dto.caption,
            identifier: dto.id ?? "",
            mediaType: InstaMediaType(dto: dto.mediaType),
            url: URL(string: dto.mediaURL ?? ""),
            permalink: URL(string: dto.permalink ?? ""),
            thumbnailURL: URL(string: dto.thumbnailURL ?? ""),
            date: dto.timestamp?.date(),
            username: dto.username ?? "")
    }
}
