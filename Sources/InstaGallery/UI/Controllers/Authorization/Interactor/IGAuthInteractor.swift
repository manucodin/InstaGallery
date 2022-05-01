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
    private let userDataSource: IGUserDataSourceInterface
    private let instagramDataSource: IGDataSourceInterface
    
    internal init(bundleDataSource: IGBundleDataSourceInterface = IGBundleDataSourceInterfaceImp(), userDataSource: IGUserDataSourceInterface = IGUserDataSourceImp(), instagramDataSource: IGDataSourceInterface = IGDataSource()) {
        self.bundleDataSource = bundleDataSource
        self.userDataSource = userDataSource
        self.instagramDataSource = instagramDataSource
    }
}

extension IGAuthInteractor: IGAuthInteractorInput {
    var authRequest: URLRequest? {
        return self.generateAuthRequest()
    }
  
    func authenticate(userCode: String) {
        instagramDataSource.authenticate(withUserCode: userCode) { [weak self] result in
            switch result {
            case .success(let userDTO):
                let user = IGUserMapper().transform(dto: userDTO)
                self?.output?.didAuthenticateUser(user: user)
            case .failure(let error):
                self?.output?.didGetError(error: error)
            }
        }
    }
    
    private func generateAuthRequest() -> URLRequest? {
        guard var urlComponent = URLComponents(string: IGAPIURLProvider().authorizeURL.absoluteString) else { return nil }
        
        urlComponent.queryItems = [
            IGConstants.ParamsKeys.clientIDKey: bundleDataSource.appID,
            IGConstants.ParamsKeys.redirectURIKey: bundleDataSource.redirectURI,
            IGConstants.ParamsKeys.scopeKey: [IGUserScope.user_media, IGUserScope.user_profile].map({ $0.rawValue }).joined(separator: ","),
            IGConstants.ParamsKeys.responseTypeKey: IGResponseType.code.rawValue
        ].map{
            return URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = urlComponent.url else { return nil }
        
        return URLRequest(url: url)
    }
}
