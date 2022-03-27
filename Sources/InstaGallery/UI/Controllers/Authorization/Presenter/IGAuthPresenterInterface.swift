//
//  IGAuthPresenterInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import WebKit

internal protocol IGAuthPresenterInterface: WKNavigationDelegate {
    func viewLoaded()
    func dismiss()
}
