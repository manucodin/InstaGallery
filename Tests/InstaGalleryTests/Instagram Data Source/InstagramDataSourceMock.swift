//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

final class InstagramDataSourceMock: InstagramDataSourceInterface {

    var invokedGetUserGallery = false
    var invokedGetUserGalleryCount = 0
    var invokedGetUserGalleryParameters: (lastItem: String?, Void)?
    var invokedGetUserGalleryParametersList = [(lastItem: String?, Void)]()
    var stubbedGetUserGalleryCompletionHandlerResult: (Result<GalleryDTO, InstaGalleryError>, Void)?

    func getUserGallery(withLastItem lastItem: String?, completionHandler: @escaping ((Result<GalleryDTO, InstaGalleryError>) -> Void)) {
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
    var stubbedGetImageCompletionHandlerResult: (Result<MediaDTO?, InstaGalleryError>, Void)?

    func getImage(withIdentifier identifier: String, completionHandler: @escaping ((Result<MediaDTO?, InstaGalleryError>) -> Void)) {
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
    var stubbedAuthenticateCompletionHandlerResult: (Result<UserDTO, InstaGalleryError>, Void)?

    func authenticate(withUserCode userCode: String, completionHandler: @escaping ((Result<UserDTO, InstaGalleryError>) -> Void)) {
        invokedAuthenticate = true
        invokedAuthenticateCount += 1
        invokedAuthenticateParameters = (userCode, ())
        invokedAuthenticateParametersList.append((userCode, ()))
        if let result = stubbedAuthenticateCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
