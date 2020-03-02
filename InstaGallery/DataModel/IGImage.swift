//
//  IGImageCover.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit

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

@objc public class IGImage :NSObject, Codable{
    var identifier          :String
    var urlString           :String
    @objc public var dateString         :String
    @objc public var date               :Date?
    @objc public var image              :UIImage?
    
    private enum CodingKeys :String, CodingKey{
        case identifier     = "id"
        case urlString      = "media_url"
        case dateString     = "timestamp"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        urlString = try container.decode(String.self, forKey: .urlString)
        dateString = try container.decode(String.self, forKey: .dateString)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
        dateFormatter.locale = .autoupdatingCurrent
        
        if let imageDate = dateFormatter.date(from: dateString){
            date = imageDate
        }
        
        if let url = URL(string: urlString){
            do{
                let dataImage = try Data(contentsOf: url)
                if let image = UIImage(data: dataImage){
                    self.image = image
                }else{
                    self.image = nil
                }
            }catch let error{
                image = nil
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {}
}
