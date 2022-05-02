//
//  InstagramDataSource.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

internal class InstagramDataSource{
    private let request = Request()
    private let userDefaultsDataSource: UserDataSourceInterface
    private let bundleDataSource: BundleDataSourceInterface
    
    init(userDefaultsDataSource: UserDataSourceInterface = UserDataSourceImp(), bundleDataSource: BundleDataSourceInterface = BundleDataSourceInterfaceImp()) {
        self.userDefaultsDataSource = userDefaultsDataSource
        self.bundleDataSource = bundleDataSource
    }
}

extension InstagramDataSource: InstagramDataSourceInterface {    
    internal func getUserGallery(withLastItem lastItem: String?, completionHandler: @escaping ((Result<GalleryDTO, InstaGalleryError>) -> Void)) {
        let params: [String : String] = [
            "fields": "id,media_url,media_type",
            "after": lastItem ?? ""
        ]
        request.getUserGallery(withParams: params, completionHandler: completionHandler)
    }

    internal func getImage(withIdentifier identifier: String, completionHandler: @escaping ((Result<MediaDTO?, InstaGalleryError>) -> Void)) {
        
        let parameters: [String : String] = [
            "fields": "id,media_url,timestamp",
        ]
        request.getUserImage(withIdentifier: identifier, withParams: parameters, completionHandler: completionHandler)
    }
    
    internal func authenticate(withUserCode userCode: String, completionHandler: @escaping ((Result<UserDTO, InstaGalleryError>) -> Void)) {
        let parameters: [String : String] = [
            "client_id": bundleDataSource.appID,
            "client_secret": bundleDataSource.clientSecret,
            "grant_type": "authorization_code",
            "redirect_uri": bundleDataSource.redirectURI,
            "code": userCode
        ]

        request.getAuthToken(withParams: parameters) { [weak self] result in
            switch result {
            case .success(let authenticationDTO):
                if let shortLiveToken = authenticationDTO.accessToken {
                    do {
                        let newUserDTO = UserDTO(token: shortLiveToken)
                        try self?.userDefaultsDataSource.saveUser(user: newUserDTO)
                        self?.getLongLiveToken(shortLiveToken: shortLiveToken, completionHandler: completionHandler)
                    } catch {
                        completionHandler(.failure(.invalidUser))
                    }
                } else {
                    completionHandler(.failure(.invalidUser))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func getLongLiveToken(shortLiveToken: String, completionHandler: @escaping ((Result<UserDTO, InstaGalleryError>) -> Void)) {
        let parameters :[String : String] = [
            "grant_type": "ig_exchange_token",
            "client_secret": bundleDataSource.clientSecret,
            "access_token": shortLiveToken
        ]
        
        request.getLongLiveToken(withParams: parameters) { [weak self] result in
            switch result {
            case .success(let authenticationDTO):
                
                if let longLiveToken = authenticationDTO.accessToken {
                    do {
                        let newUserDTO = UserDTO().updating(token: longLiveToken)
                        try self?.userDefaultsDataSource.saveUser(user: newUserDTO)
                        self?.getUserInfo(completionHandler: completionHandler)
                    } catch {
                        self?.getUserInfo(completionHandler: completionHandler)
                    }
                } else {
                    self?.getUserInfo(completionHandler: completionHandler)
                }
            case.failure(_):
                self?.getUserInfo(completionHandler: completionHandler)
            }
        }
    }
    
    private func getUserInfo(completionHandler: @escaping ((Result<UserDTO, InstaGalleryError>) -> Void)) {
        let parameters :[String : String] = [
            "fields": "id,username",
        ]
        
        request.getUserInfo(withParams: parameters) { [weak self] result in
            switch result {
            case .success(let userDTO):
                do {
                    let newUserDTO = userDTO.updating(token: self?.userDefaultsDataSource.userToken)
                    try self?.userDefaultsDataSource.saveUser(user: newUserDTO)
                    completionHandler(.success(newUserDTO))
                } catch {
                    completionHandler(.failure(.invalidUser))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
