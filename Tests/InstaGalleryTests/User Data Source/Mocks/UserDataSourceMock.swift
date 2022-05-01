//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

final class UserDataSourceMock: IGUserDataSourceInterface {
    
    var invokedUserIDGetter = false
    var invokedUserIDGetterCount = 0
    var stubbedUserID: String!

    var userID: String? {
        invokedUserIDGetter = true
        invokedUserIDGetterCount += 1
        return stubbedUserID
    }

    var invokedUserNameGetter = false
    var invokedUserNameGetterCount = 0
    var stubbedUserName: String!

    var userName: String? {
        invokedUserNameGetter = true
        invokedUserNameGetterCount += 1
        return stubbedUserName
    }

    var invokedUserTokenGetter = false
    var invokedUserTokenGetterCount = 0
    var stubbedUserToken: String!

    var userToken: String? {
        invokedUserTokenGetter = true
        invokedUserTokenGetterCount += 1
        return stubbedUserToken
    }

    var invokedIsUserLoggedGetter = false
    var invokedIsUserLoggedGetterCount = 0
    var stubbedIsUserLogged: Bool! = false

    var isUserLogged: Bool {
        invokedIsUserLoggedGetter = true
        invokedIsUserLoggedGetterCount += 1
        return stubbedIsUserLogged
    }

    var invokedSaveUser = false
    var invokedSaveUserCount = 0
    var invokedSaveUserParameters: (user: IGUserDTO, Void)?
    var invokedSaveUserParametersList = [(user: IGUserDTO, Void)]()
    var stubbedSaveUserError: Error?

    func saveUser(user: IGUserDTO) throws {
        invokedSaveUser = true
        invokedSaveUserCount += 1
        invokedSaveUserParameters = (user, ())
        invokedSaveUserParametersList.append((user, ()))
        if let error = stubbedSaveUserError {
            throw error
        }
    }

    var invokedGetUser = false
    var invokedGetUserCount = 0
    var stubbedGetUserResult: IGUserDTO!

    func getUser() -> IGUserDTO? {
        invokedGetUser = true
        invokedGetUserCount += 1
        return stubbedGetUserResult
    }

    var invokedClearAll = false
    var invokedClearAllCount = 0

    func clearAll() {
        invokedClearAll = true
        invokedClearAllCount += 1
    }

    var invokedSave = false
    var invokedSaveCount = 0
    var invokedSaveParameters: (value: Any?, key: String)?
    var invokedSaveParametersList = [(value: Any?, key: String)]()

    func save(value: Any?, withKey key: String) {
        invokedSave = true
        invokedSaveCount += 1
        invokedSaveParameters = (value, key)
        invokedSaveParametersList.append((value, key))
    }

    var invokedGetData = false
    var invokedGetDataCount = 0
    var invokedGetDataParameters: (key: String, Void)?
    var invokedGetDataParametersList = [(key: String, Void)]()
    var stubbedGetDataResult: Data!

    func getData(withKey key: String) -> Data? {
        invokedGetData = true
        invokedGetDataCount += 1
        invokedGetDataParameters = (key, ())
        invokedGetDataParametersList.append((key, ()))
        return stubbedGetDataResult
    }

    var invokedGetValue = false
    var invokedGetValueCount = 0
    var invokedGetValueParameters: (key: String, Void)?
    var invokedGetValueParametersList = [(key: String, Void)]()
    var stubbedGetValueResult: Any!

    func getValue(withKey key: String) -> Any? {
        invokedGetValue = true
        invokedGetValueCount += 1
        invokedGetValueParameters = (key, ())
        invokedGetValueParametersList.append((key, ()))
        return stubbedGetValueResult
    }

    var invokedRemoveValue = false
    var invokedRemoveValueCount = 0
    var invokedRemoveValueParameters: (key: String, Void)?
    var invokedRemoveValueParametersList = [(key: String, Void)]()

    func removeValue(withKey key: String) {
        invokedRemoveValue = true
        invokedRemoveValueCount += 1
        invokedRemoveValueParameters = (key, ())
        invokedRemoveValueParametersList.append((key, ()))
    }
}
