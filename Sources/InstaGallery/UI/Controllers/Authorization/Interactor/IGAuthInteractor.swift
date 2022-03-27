//
//  IGAuthInteractor.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class IGAuthInteractor {
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
            IGConstants.ParamsKeys.clientIDKey: bundleDataSource.appID,
            IGConstants.ParamsKeys.redirectURIKey: bundleDataSource.redirectURI,
            IGConstants.ParamsKeys.scopeKey: [IGUserScope.user_media, IGUserScope.user_profile].map({ $0.rawValue }).joined(separator: ","),
            IGConstants.ParamsKeys.responseTypeKey: IGResponseType.code.rawValue
        ].map{ URLQueryItem(name: $0.key, value: $0.value) }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else { return }
        
        let urlRequest = URLRequest(url: url)
        output?.didGenerateAuthRequest(request: urlRequest)
    }
    
    func authenticate(userCode: String) {
        instagramDataSource.authenticate(withUserCode: userCode, withCompletionBlock: { [weak self] userDTO in
            let user = IGUserMapper.transform(dto: userDTO)
            self?.output?.didAuthenticateUser(user: user)
        }, functionError: { _ in })
    }
}
