//
//  IGImageDTP.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal struct IGMediaDTO: Codable {
    internal let caption: String?
    internal let id: String?
    internal let mediaType: IGMediaTypeDTO?
    internal let mediaURL: String?
    internal let permalink: String?
    internal let thumbnailURL: String?
    internal let timestamp: String?
    internal let username: String?
    
    private enum CodingKeys :String, CodingKey{
        case caption
        case id
        case mediaType = "media_type"
        case mediaURL = "media_url"
        case permalink
        case thumbnailURL = "thumbnail_url"
        case timestamp
        case username
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        caption = try container.decodeIfPresent(String.self, forKey: .caption)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        mediaType = try container.decodeIfPresent(IGMediaTypeDTO.self, forKey: .mediaType)
        mediaURL = try container.decodeIfPresent(String.self, forKey: .mediaURL)
        permalink = try container.decodeIfPresent(String.self, forKey: .permalink)
        thumbnailURL = try container.decodeIfPresent(String.self, forKey: .thumbnailURL)
        timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp)
        username = try container.decodeIfPresent(String.self, forKey: .username)
    }
    
    func encode(to encoder: Encoder) throws {}
}
