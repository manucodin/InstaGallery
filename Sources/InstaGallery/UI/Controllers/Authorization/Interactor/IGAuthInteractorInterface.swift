//
//  IGAuthInteractorInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol IGAuthInteractorInterface {
    var appID: String { get }
    var redirectURI: String { get }
    var scopes: [IGUserScope] { get }
    var resposeType: IGResponseType { get }
}

internal protocol IGAuthInteractorInput {
    var authRequest: URLRequest? { get }
    func authenticate(userCode: String)
}

internal protocol IGAuthInteractorOutput: AnyObject {
    func didAuthenticateUser(user: IGUser)
    func didGetError(error: Error)
}
