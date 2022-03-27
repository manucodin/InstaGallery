//
//  IGSessionDelegate.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

public protocol IGSessionDelegate: AnyObject {
    func userLogged()
    func userDisconnected()
}
