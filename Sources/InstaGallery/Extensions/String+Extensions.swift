//
//  String+Extensions.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func date() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
        dateFormatter.locale = .autoupdatingCurrent
        
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
}
