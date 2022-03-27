//
//  IGRequest.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

class IGRequest :IGBaseRequest{
    
    private let apiURLProvider = IGAPIURLProvider()
    private let apiGraphURLProvider = IGAPIGraphURLProvider()
    
    func getAuthToken(withParams params: [String : String], withCompletionBlock functionOK:@escaping((IGUserDTO) -> Void), functionError :@escaping((Error) -> Void)){
        let url = apiURLProvider.authURL()
        makeRequest(url: url, withMethod: .post, withParams: params, withCompletionBlock: {response, _ in
            let responseDict = response as? [String : Any] ?? [:]
            IGRequest.mapUserInfo(userInfo: responseDict)
            self.getLongLiveToken(functionOK: functionOK, functionError: functionError)
        }, withErroBlock: {error in
            functionError(error)
        })
    }
    
    //TODO: - Quitar gestion de parametros
    func refreshToken(functionOK :@escaping(() -> Void), functionError :@escaping((Error) -> Void)){
        let url = apiURLProvider.refreshToken()
        let params :[String : Any] = [
            "grant_type" :"ig_refresh_token",
            "access_token" :IGManagerUtils.getUserToken() ?? ""
        ]
        
        makeRequest(url: url, withMethod: .get, withParams: params, withCompletionBlock: {response, _ in
            let responseDict = response as? [String : Any] ?? [:]
            IGRequest.mapUserInfo(userInfo: responseDict)
            functionOK()
        }, withErroBlock: functionError)
    }
    
    //TODO: - Quitar gestion de parametros
    func getUserGallery(nextPage :String? = nil, withCompletionBlock functionOK:@escaping(([IGImageCover], String?) -> Void), functionError :@escaping((Error) -> Void)){
        let url = apiGraphURLProvider.mediaURL()
        var parameters :[String : Any] = [
            "fields" : "id,media_url,media_type",
            "access_token" : IGManagerUtils.getUserToken() ?? ""
        ]
        
        if let nextItem = nextPage{
            parameters["after"] = nextItem
        }
        
        makeRequest(url: url, withMethod: .get, withParams: parameters, withCompletionBlock: {response, _ in
            do{
                let responseDict = response as? [String : Any] ?? [:]
                var dataDict = responseDict["data"] as? [[String : Any]] ?? [[:]]
                
                dataDict.removeAll(where: {
                    $0["media_type"] as? String ?? "" != "IMAGE"
                })
                
                let jsonData = try JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
                let albums = try JSONDecoder().decode([IGImageCover].self, from: jsonData)
                
                let paggingDict = responseDict["paging"] as? [String : Any] ?? [:]
                let cursorsDict = paggingDict["cursors"] as? [String : Any] ?? [:]
                
                var nextItem = cursorsDict["after"] as? String? ?? nil
                
                if(paggingDict["next"] == nil){
                    nextItem = nil
                }
                functionOK(albums, nextItem)
            }catch let error{
                functionError(error)
            }
        }, withErroBlock: {error in
            functionError(error)
        })
    }
    
    //TODO: - Quitar gestion de parametros
    func getUserImage(withIdentifier identifier :String, withCompletionBlock functionOK:@escaping((IGImage) -> Void), errorBlock functionError :@escaping((Error) -> Void)){
        let url = apiGraphURLProvider.mediaURL(withIdentifier: identifier)
        let parameters :[String : Any] = [
            "fields" : "id,media_url,timestamp",
            "access_token" : IGManagerUtils.getUserToken() ?? ""
        ]
        
        makeRequest(url: url, withMethod: .get, withParams: parameters, withCompletionBlock: {response, _ in
            do{
                let responseDict = response as? [String : Any] ?? [:]
                let jsonData = try JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
                let igImage = try JSONDecoder().decode(IGImage.self, from: jsonData)
                functionOK(igImage)
            }catch let error{
                functionError(error)
            }
        }, withErroBlock: {error in
            functionError(error)
        })
    }
    
    //TODO: - Quitar gestion de parametros
    private func getLongLiveToken(functionOK :@escaping((IGUserDTO) -> Void), functionError :@escaping ((Error) -> Void)){
        let bundle = Bundle.main
        let url = apiURLProvider.tokenURL()
        let parameters :[String : Any] = [
            "grant_type"    :"ig_exchange_token",
            "client_secret" :bundle.object(forInfoDictionaryKey: "InstagramClientSecret") as? String ?? "",
            "access_token"  :IGManagerUtils.getUserToken() ?? ""
        ]
        
        makeRequest(url: url, withMethod: .get, withParams: parameters,withCompletionBlock: {response, _ in
            let responseDict = response as? [String : Any] ?? [:]
            IGRequest.mapUserInfo(userInfo: responseDict)
            self.getUserInfo(withCompletionBlock: functionOK, functionError: functionError)
        }, withErroBlock: functionError)
    }
    
    //TODO: - Quitar gestion de parametros
    private func getUserInfo(withCompletionBlock functionOK:@escaping((IGUserDTO) -> Void), functionError :@escaping((Error) -> Void)){
        let url = apiGraphURLProvider.userURL()
        let parameters :[String : Any] = [
            "fields" : "id,username",
            "access_token" : IGManagerUtils.getUserToken() ?? ""
        ]
        
        makeRequest(url: url, withMethod: .get, withParams: parameters, withCompletionBlock: {response, _ in
            let responseDict = response as? [String : Any] ?? [:]
            IGRequest.mapUserInfo(userInfo: responseDict)
            do{
                
                let jsonData = try JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
                let igUser = try JSONDecoder().decode(IGUserDTO.self, from: jsonData)
                functionOK(igUser)
            }catch let error{
                functionError(error)
            }
        }, withErroBlock: {error in
            functionError(error)
        })
    }
    
    private static func mapUserInfo(userInfo :[String : Any]){
        if let userIdentifier = userInfo["user_id"] as? Int{
            IGManagerUtils.saveUserIdentifier(identifier: userIdentifier)
        }
        
        if let token = userInfo["access_token"] as? String{
            IGManagerUtils.saveAccessToken(token: token)
        }
        
        if let userName = userInfo["username"] as? String{
            IGManagerUtils.saveUserName(name: userName)
        }
    }
}
