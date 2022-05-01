//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

final class InstagramDataSourceMock: IGDataSourceInterface {

    var invokedGetUserGallery = false
    var invokedGetUserGalleryCount = 0
    var invokedGetUserGalleryParameters: (lastItem: String?, Void)?
    var invokedGetUserGalleryParametersList = [(lastItem: String?, Void)]()
    var stubbedGetUserGalleryCompletionHandlerResult: (Result<IGGalleryDTO, IGError>, Void)?

    func getUserGallery(withLastItem lastItem: String?, completionHandler: @escaping ((Result<IGGalleryDTO, IGError>) -> Void)) {
        invokedGetUserGallery = true
        invokedGetUserGalleryCount += 1
        invokedGetUserGalleryParameters = (lastItem, ())
        invokedGetUserGalleryParametersList.append((lastItem, ()))
        if let result = stubbedGetUserGalleryCompletionHandlerResult {
            completionHandler(result.0)
        }
    }

    var invokedGetImage = false
    var invokedGetImageCount = 0
    var invokedGetImageParameters: (identifier: String, Void)?
    var invokedGetImageParametersList = [(identifier: String, Void)]()
    var stubbedGetImageCompletionHandlerResult: (Result<IGMediaDTO?, IGError>, Void)?

    func getImage(withIdentifier identifier: String, completionHandler: @escaping ((Result<IGMediaDTO?, IGError>) -> Void)) {
        invokedGetImage = true
        invokedGetImageCount += 1
        invokedGetImageParameters = (identifier, ())
        invokedGetImageParametersList.append((identifier, ()))
        if let result = stubbedGetImageCompletionHandlerResult {
            completionHandler(result.0)
        }
    }

    var invokedAuthenticate = false
    var invokedAuthenticateCount = 0
    var invokedAuthenticateParameters: (userCode: String, Void)?
    var invokedAuthenticateParametersList = [(userCode: String, Void)]()
    var stubbedAuthenticateCompletionHandlerResult: (Result<IGUserDTO, IGError>, Void)?

    func authenticate(withUserCode userCode: String, completionHandler: @escaping ((Result<IGUserDTO, IGError>) -> Void)) {
        invokedAuthenticate = true
        invokedAuthenticateCount += 1
        invokedAuthenticateParameters = (userCode, ())
        invokedAuthenticateParametersList.append((userCode, ()))
        if let result = stubbedAuthenticateCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
