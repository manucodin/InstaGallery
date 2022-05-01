//
//  IGManager.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

internal class IGDataSource{
    private let request = IGRequest()
    private let userDefaultsDataSource: IGUserDefaultsDataSourceInterface
    private let bundleDataSource: IGBundleDataSourceInterface
    
    internal var appID: String {
        return bundleDataSource.appID
    }
    
    internal var clientSecret: String {
        return bundleDataSource.clientSecret
    }
    
    internal var redirectURI: String {
        return bundleDataSource.redirectURI
    }
    
    init(userDefaultsDataSource: IGUserDefaultsDataSourceInterface = IGUserDefaultsDataSourceImp(), bundleDataSource: IGBundleDataSourceInterface = IGBundleDataSourceInterfaceImp()) {
        self.userDefaultsDataSource = userDefaultsDataSource
        self.bundleDataSource = bundleDataSource
    }
}

extension IGDataSource: IGDataSourceInterface {
    internal func authenticate(withUserCode userCode: String, completionHandler: @escaping ((Result<IGUserDTO, IGError>) -> Void)) {
        let parameters: [String : String] = [
            "app_id": appID,
            "app_secret": clientSecret,
            "grant_type": "authorization_code",
            "redirect_uri": redirectURI,
            "code": userCode
        ]

        request.getAuthToken(withParams: parameters) { [weak self] result in
            switch result {
            case .success(let token):
                self?.getLongLiveToken(completionHandler: completionHandler)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    internal func getUserGallery(withLastItem lastItem: String?, completionHandler: @escaping ((Result<IGGalleryDTO, IGError>) -> Void)) {
        let params: [String : String] = [
            "fields": "id,media_url,media_type",
            "after": lastItem ?? ""
        ]
        request.getUserGallery(withParams: params, completionHandler: completionHandler)
    }

    internal func getImage(withIdentifier identifier: String, completionHandler: @escaping ((Result<IGMediaDTO?, IGError>) -> Void)) {
        
        let parameters: [String : String] = [
            "fields": "id,media_url,timestamp",
        ]
        request.getUserImage(withIdentifier: identifier, withParams: parameters, completionHandler: completionHandler)
    }
    
    private func getLongLiveToken(completionHandler: @escaping ((Result<IGUserDTO, IGError>) -> Void)) {
        let parameters :[String : String] = [
            "grant_type": "ig_exchange_token",
            "client_secret": clientSecret,
        ]
        
        request.getLongLiveToken(withParams: parameters) { result in
            switch result {
            case .success(let token):
                self.getUserInfo(completionHandler: completionHandler)
            case.failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func getUserInfo(completionHandler: @escaping ((Result<IGUserDTO, IGError>) -> Void)) {
        let parameters :[String : String] = [
            "fields": "id,username",
        ]
        
        request.getUserInfo(withParams: parameters) { [weak self] result in
            switch result {
            case .success(let userDTO):
                do {
                    try self?.userDefaultsDataSource.saveUser(user: userDTO)
                    completionHandler(.success(userDTO))
                } catch {
                    completionHandler(.failure(.invalidUser))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
