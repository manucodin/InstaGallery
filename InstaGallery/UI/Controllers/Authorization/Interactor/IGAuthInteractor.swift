//
//  IGAuthInteractor.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGAuthInteractor {
    
    var appID: String {
        return bundleDataSource.appID
    }
    
    var clientSecret: String {
        return bundleDataSource.clientSecret
    }
    
    var redirectURI: String {
        return bundleDataSource.redirectURI
    }
    
    var scopes: String {
        return [
            IGUserScope.user_profile.rawValue,
            IGUserScope.user_media.rawValue
        ].joined(separator: ",")
    }
    
    var resposeType: String {
        return IGResponseType.code.rawValue
    }
    
    weak var output: IGAuthInteractorOutput?
    
    private let bundleDataSource: IGBundleDataSourceInterface
    private let instagramDataSource: IGDataSourceInterface
    
    internal init(bundleDataSource: IGBundleDataSourceInterface = IGBundleDataSourceInterfaceImp(), instagramDataSource: IGDataSourceInterface = IGDataSource()) {
        self.bundleDataSource = bundleDataSource
        self.instagramDataSource = instagramDataSource
    }
}

extension IGAuthInteractor: IGAuthInteractorInput {
    func generateAuthRequest() {
        guard var urlComponent = URLComponents(string: IGAPIURLProvider().authorizeURL().absoluteString) else { return }

        let queryItems: [URLQueryItem] = [
            IGConstants.ParamsKeys.clientIDKey: appID,
            IGConstants.ParamsKeys.redirectURIKey: redirectURI,
            IGConstants.ParamsKeys.scopeKey: scopes,
            IGConstants.ParamsKeys.responseTypeKey: resposeType
        ].map{ URLQueryItem(name: $0.key, value: $0.value) }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else { return }
        
        let urlRequest = URLRequest(url: url)
        output?.didGenerateAuthRequest(request: urlRequest)
    }
    
    func authenticate(userCode: String) {
        let parameters :[String : String] = [
            "app_id" : appID,
            "app_secret" : clientSecret,
            "grant_type" : "authorization_code",
            "redirect_uri" : redirectURI,
            "code" : userCode
        ]
        
        instagramDataSource.getAuthToken(withParams: parameters, withCompletionBlock: { [weak self] userDTO in
            let user = IGUserMapper.transform(dto: userDTO)
            self?.output?.didAuthenticateUser(user: user)
        }, functionError: { [weak self] error in
            self?.output?.didGetError(error: error)
        })
    }
}
