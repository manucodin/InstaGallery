//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 2/5/22.
//

import Foundation
@testable import InstaGallery

final class AuthViewMock: AuthControllerInterface {

    var invokedSetupView = false
    var invokedSetupViewCount = 0

    func setupView() {
        invokedSetupView = true
        invokedSetupViewCount += 1
    }

    var invokedDismissView = false
    var invokedDismissViewCount = 0

    func dismissView() {
        invokedDismissView = true
        invokedDismissViewCount += 1
    }

    var invokedLoadRequest = false
    var invokedLoadRequestCount = 0
    var invokedLoadRequestParameters: (request: URLRequest, Void)?
    var invokedLoadRequestParametersList = [(request: URLRequest, Void)]()

    func loadRequest(request: URLRequest) {
        invokedLoadRequest = true
        invokedLoadRequestCount += 1
        invokedLoadRequestParameters = (request, ())
        invokedLoadRequestParametersList.append((request, ()))
    }

    var invokedDidLoadUser = false
    var invokedDidLoadUserCount = 0
    var invokedDidLoadUserParameters: (user: User, Void)?
    var invokedDidLoadUserParametersList = [(user: User, Void)]()

    func didLoadUser(user: User) {
        invokedDidLoadUser = true
        invokedDidLoadUserCount += 1
        invokedDidLoadUserParameters = (user, ())
        invokedDidLoadUserParametersList.append((user, ()))
    }
}
