//
//  AuthPresenterInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import WebKit

internal protocol AuthPresenterInterface: WKNavigationDelegate {
    func viewLoaded()
    func load()
    func dismiss()
}
