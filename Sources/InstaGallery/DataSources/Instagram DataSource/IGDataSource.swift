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
    internal func authenticate(withUserCode userCode: String, withCompletionBlock functionOK: @escaping ((IGUserDTO) -> Void), functionError: @escaping ((Error) -> Void)) {
        let parameters: [String : String] = [
            "app_id": appID,
            "app_secret": clientSecret,
            "grant_type": "authorization_code",
            "redirect_uri": redirectURI,
            "code": userCode
        ]
        
        request.getAuthToken(withParams: parameters, withCompletionBlock: { [weak self] token in
            self?.getLongLiveToken(withToken: token, withCompletionBlock: functionOK, functionError: functionError)
        }, functionError: functionError)
    }
    
    internal func getUserGallery(withLastItem lastItem: String?, withCompletionBlock functionOK:@escaping(([IGMediaDTO], String?) -> Void), errorBlock functionError:@escaping((Error) -> Void)){
        guard let token = userDefaultsDataSource.getUser()?.token else { return }

        let params: [String : String] = [
            "fields": "id,media_url,media_type",
            "access_token": token,
            "after": lastItem ?? ""
        ]
        
        request.getUserGallery(withParams: params, withCompletionBlock: functionOK, functionError: functionError)
    }
    
    internal func getImage(withIdentifier identifier :String, withCompletionBlock functionOK :@escaping((IGMediaDTO) -> Void), functionError :@escaping((Error) -> Void)){
        guard let token = userDefaultsDataSource.getUser()?.token else { return }
        
        let parameters: [String : String] = [
            "fields": "id,media_url,timestamp",
            "access_token": token
        ]
        request.getUserImage(withIdentifier: identifier, withParams: parameters, withCompletionBlock: functionOK, errorBlock: functionError)
    }
    
    private func getLongLiveToken(withToken token: String, withCompletionBlock functionOK: @escaping ((IGUserDTO) -> Void), functionError: @escaping ((Error) -> Void)) {
        let parameters :[String : String] = [
            "grant_type": "ig_exchange_token",
            "client_secret": clientSecret,
            "access_token": token
        ]
        
        request.getLongLiveToken(withParams: parameters, functionOK: { token in
            self.getUserInfo(withToken: token, withCompletionBlock: functionOK, functionError: functionError)
        }, functionError: functionError)
    }
    
    private func getUserInfo(withToken token: String, withCompletionBlock functionOK: @escaping ((IGUserDTO) -> Void), functionError: @escaping ((Error) -> Void)) {
        let parameters :[String : String] = [
            "fields": "id,username",
            "access_token": token
        ]
        
        request.getUserInfo(withParams: parameters, withCompletionBlock: { [weak self] userInfoDTO in
            let userDTO = userInfoDTO.updating(token: token)
            self?.userDefaultsDataSource.saveUser(user: userDTO)
            functionOK(userDTO)
        }, functionError: functionError)
    }
}
