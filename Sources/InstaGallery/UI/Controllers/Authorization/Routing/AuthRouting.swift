//
//  AuthRouting.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class AuthRouting {
    weak var view: AuthControllerInterface?
}

extension AuthRouting: AuthRoutingInterface {
    func dismiss() {
        guard let view = view else { return }
        
        view.dismissView()
    }
}
