//
//  IGUserDefaultsInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation


internal protocol IGUserDefaultsInterface {
    func save(value: Any?, withKey key: String)
    func getData(withKey key: String) -> Data?
    func getValue(withKey key: String) -> Any?
    func removeValue(withKey key: String)
}

