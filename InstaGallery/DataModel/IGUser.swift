//
//  IGUser.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 26/02/2020.
//  Copyright © 2020 MRodriguez. All rights reserved.
//

import Foundation

@objc public class IGUser :NSObject, Codable{
    public var identifier          :String
    public var account                :String
    
    private enum CodingKeys :String, CodingKey{
        case identifier     = "id"
        case account           = "username"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        account = try container.decode(String.self, forKey: .account)
    }
    
    public func encode(to encoder: Encoder) throws {}
}
