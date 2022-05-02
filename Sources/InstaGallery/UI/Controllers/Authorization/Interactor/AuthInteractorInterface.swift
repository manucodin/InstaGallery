//
//  AuthInteractorInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol AuthInteractorInterface {
    var appID: String { get }
    var redirectURI: String { get }
    var scopes: [UserScope] { get }
    var resposeType: ResponseType { get }
}

internal protocol AuthInteractorInput {
    var authRequest: URLRequest? { get }
    func authenticate(userCode: String)
}

internal protocol AuthInteractorOutput: AnyObject {
    func didAuthenticateUser(user: User)
    func didGetError(error: Error)
}
