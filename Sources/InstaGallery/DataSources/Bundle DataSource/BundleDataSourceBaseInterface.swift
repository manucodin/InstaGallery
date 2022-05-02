//
//  BundleDataSourceBaseInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol BundleDataSourceBaseInterface {
    var bundle: Bundle { get }
    func getStringValueForKey(key: String) -> String
}

extension BundleDataSourceBaseInterface {
    var bundle: Bundle { return Bundle.main }
    
    func getStringValueForKey(key: String) -> String {
        guard let value = bundle.object(forInfoDictionaryKey: key) as? String else { return "" }
        
        return value
    }
}
