//
//  AuthInteractor.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal class AuthInteractor {
    weak var output: AuthInteractorOutput?
    
    private let bundleDataSource: BundleDataSourceInterface
    private let userDataSource: UserDataSourceInterface
    private let instagramDataSource: InstagramDataSourceInterface
    
    internal init(
        bundleDataSource: BundleDataSourceInterface = BundleDataSourceInterfaceImp(),
        userDataSource: UserDataSourceInterface = UserDataSourceImp(),
        instagramDataSource: InstagramDataSourceInterface = InstagramDataSource()
    ) {
        self.bundleDataSource = bundleDataSource
        self.userDataSource = userDataSource
        self.instagramDataSource = instagramDataSource
    }
}

extension AuthInteractor: AuthInteractorInput {
    var authRequest: URLRequest? {
        return generateAuthRequest()
    }
  
    func authenticate(userCode: String) {
        instagramDataSource.authenticate(withUserCode: userCode) { [weak self] result in
            switch result {
            case .success(let userDTO):
                let user = UserMapper().transform(dto: userDTO)
                self?.output?.didAuthenticateUser(user: user)
            case .failure(let error):
                self?.output?.didGetError(error: error)
            }
        }
    }
    
    private func generateAuthRequest() -> URLRequest? {
        guard var urlComponent = URLComponents(string: AuthURLProvider().authorizeURL.absoluteString) else { return nil }
        
        urlComponent.queryItems = generateQueryItems()
        
        guard let url = urlComponent.url else { return nil }
        
        return URLRequest(url: url)
    }
    
    private func generateQueryItems() -> [URLQueryItem] {
        let scopes = [UserScope.user_media, UserScope.user_profile].map({ $0.rawValue }).joined(separator: ",")
        let params = [
            Constants.ParamsKeys.clientIDKey: bundleDataSource.appID,
            Constants.ParamsKeys.redirectURIKey: bundleDataSource.redirectURI,
            Constants.ParamsKeys.scopeKey: scopes,
            Constants.ParamsKeys.responseTypeKey: ResponseType.code.rawValue
        ]
        
        return params.map{ URLQueryItem(name: $0.key, value: $0.value) }
    }
}
