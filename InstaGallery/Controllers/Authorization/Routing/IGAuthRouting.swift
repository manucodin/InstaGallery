//
//  IGAuthRouting.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGAuthRouting {
    
    weak var view: IGAuthControllerInterface?
    
}

extension IGAuthRouting: IGAuthRoutingInterface {
    func dismiss() {
        guard let view = view else { return }
        
    }
}
