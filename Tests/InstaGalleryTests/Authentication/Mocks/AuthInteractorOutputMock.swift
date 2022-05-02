//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

final class AuthInteractorOutputMock: AuthInteractorOutput {

    var invokedDidAuthenticateUser = false
    var invokedDidAuthenticateUserCount = 0
    var invokedDidAuthenticateUserParameters: (user: User, Void)?
    var invokedDidAuthenticateUserParametersList = [(user: User, Void)]()

    func didAuthenticateUser(user: User) {
        invokedDidAuthenticateUser = true
        invokedDidAuthenticateUserCount += 1
        invokedDidAuthenticateUserParameters = (user, ())
        invokedDidAuthenticateUserParametersList.append((user, ()))
    }

    var invokedDidGetError = false
    var invokedDidGetErrorCount = 0
    var invokedDidGetErrorParameters: (error: Error, Void)?
    var invokedDidGetErrorParametersList = [(error: Error, Void)]()

    func didGetError(error: Error) {
        invokedDidGetError = true
        invokedDidGetErrorCount += 1
        invokedDidGetErrorParameters = (error, ())
        invokedDidGetErrorParametersList.append((error, ()))
    }
}
