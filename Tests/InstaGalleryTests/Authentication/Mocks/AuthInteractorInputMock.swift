//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

final class AuthInteractorInputMock: IGAuthInteractorInput {
    
    var invokedAuthRequestGetter = false
    var invokedAuthRequestGetterCount = 0
    var stubbedAuthRequest: URLRequest!

    var authRequest: URLRequest? {
        invokedAuthRequestGetter = true
        invokedAuthRequestGetterCount += 1
        return stubbedAuthRequest
    }

    var invokedAuthenticate = false
    var invokedAuthenticateCount = 0
    var invokedAuthenticateParameters: (userCode: String, Void)?
    var invokedAuthenticateParametersList = [(userCode: String, Void)]()

    func authenticate(userCode: String) {
        invokedAuthenticate = true
        invokedAuthenticateCount += 1
        invokedAuthenticateParameters = (userCode, ())
        invokedAuthenticateParametersList.append((userCode, ()))
    }
}
