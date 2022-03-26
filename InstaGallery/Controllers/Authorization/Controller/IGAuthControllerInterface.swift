//
//  IGAuthControllerInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol IGAuthControllerInterface: AnyObject {    
    func setupView()
    func loadRequest(request: URLRequest)
    func didLoadUser(user: IGUser)
}
