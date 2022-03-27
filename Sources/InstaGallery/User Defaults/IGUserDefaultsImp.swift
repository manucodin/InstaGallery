//
//  IGUserDefaultsImp.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGUserDefaultsImp: IGUserDefaultsInterface {
    func save(value: Any?, withKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getData(withKey key: String) -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
    
    func getValue(withKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    func removeValue(withKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
