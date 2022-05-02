//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

final class AuthRoutingMock: AuthRoutingInterface {

    var invokedDismiss = false
    var invokedDismissCount = 0

    func dismiss() {
        invokedDismiss = true
        invokedDismissCount += 1
    }
}
