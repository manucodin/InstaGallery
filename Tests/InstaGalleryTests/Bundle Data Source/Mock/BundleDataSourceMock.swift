//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

final class BundleDataSourceMock: IGBundleDataSourceInterface {

    var invokedAppIDGetter = false
    var invokedAppIDGetterCount = 0
    var stubbedAppID: String! = ""

    var appID: String {
        invokedAppIDGetter = true
        invokedAppIDGetterCount += 1
        return stubbedAppID
    }

    var invokedClientSecretGetter = false
    var invokedClientSecretGetterCount = 0
    var stubbedClientSecret: String! = ""

    var clientSecret: String {
        invokedClientSecretGetter = true
        invokedClientSecretGetterCount += 1
        return stubbedClientSecret
    }

    var invokedRedirectURIGetter = false
    var invokedRedirectURIGetterCount = 0
    var stubbedRedirectURI: String! = ""

    var redirectURI: String {
        invokedRedirectURIGetter = true
        invokedRedirectURIGetterCount += 1
        return stubbedRedirectURI
    }

    var invokedBundleGetter = false
    var invokedBundleGetterCount = 0
    var stubbedBundle: Bundle!

    var bundle: Bundle {
        invokedBundleGetter = true
        invokedBundleGetterCount += 1
        return stubbedBundle
    }

    var invokedGetStringValueForKey = false
    var invokedGetStringValueForKeyCount = 0
    var invokedGetStringValueForKeyParameters: (key: String, Void)?
    var invokedGetStringValueForKeyParametersList = [(key: String, Void)]()
    var stubbedGetStringValueForKeyResult: String! = ""

    func getStringValueForKey(key: String) -> String {
        invokedGetStringValueForKey = true
        invokedGetStringValueForKeyCount += 1
        invokedGetStringValueForKeyParameters = (key, ())
        invokedGetStringValueForKeyParametersList.append((key, ()))
        return stubbedGetStringValueForKeyResult
    }
}
