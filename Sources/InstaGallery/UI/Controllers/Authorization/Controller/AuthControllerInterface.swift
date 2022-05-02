//
//  AuthControllerInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol AuthControllerInterface: AnyObject {    
    func setupView()
    func dismissView()
    func loadRequest(request: URLRequest)
    func didLoadUser(user: User)
}
