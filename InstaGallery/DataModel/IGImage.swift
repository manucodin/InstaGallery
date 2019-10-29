//
//  IGImageCover.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation

@objc class IGImageCover :NSObject, Codable{
    var identifier          :String
    var urlString           :String
    
    private enum CodingKeys :String, CodingKey{
        case identifier     = "id"
        case urlString      = "media_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        urlString = try container.decode(String.self, forKey: .urlString)
    }
    
    func encode(to encoder: Encoder) throws {}
}

@objc class IGImage :NSObject, Codable{
    var identifier          :String
    var urlString           :String
    var dateString          :String
    
    private enum CodingKeys :String, CodingKey{
        case identifier     = "id"
        case urlString      = "media_url"
        case dateString     = "timestamp"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        urlString = try container.decode(String.self, forKey: .urlString)
        dateString = try container.decode(String.self, forKey: .dateString)
    }
    
    func encode(to encoder: Encoder) throws {}
}
