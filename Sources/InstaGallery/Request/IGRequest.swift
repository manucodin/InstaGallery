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
            
    func getUserGallery(withParams params: [String : String], withCompletionBlock functionOK:@escaping(([IGMediaDTO], String?) -> Void), functionError :@escaping((Error) -> Void)){
        
        
        makeRequest(url: apiGraphURLProvider.mediaURL(), withMethod: .get, withParams: params, withCompletionBlock: {response, _ in
            do{
                let responseDict = response as? [String : Any] ?? [:]
                var dataDict = responseDict["data"] as? [[String : Any]] ?? [[:]]
                
                dataDict.removeAll(where: {
                    $0["media_type"] as? String ?? "" != "IMAGE"
                })
                
                let jsonData = try JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
                let albums = try JSONDecoder().decode([IGMediaDTO].self, from: jsonData)
                
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
    
    func getUserImage(withIdentifier identifier :String, withParams params: [String : String], withCompletionBlock functionOK:@escaping((IGMediaDTO) -> Void), errorBlock functionError :@escaping((Error) -> Void)){
        makeRequest(url: apiGraphURLProvider.mediaURL(withIdentifier: identifier), withMethod: .get, withParams: params, withCompletionBlock: {response, _ in
            do{
                let responseDict = response as? [String : Any] ?? [:]
                let jsonData = try JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
                let igImage = try JSONDecoder().decode(IGMediaDTO.self, from: jsonData)
                functionOK(igImage)
            }catch let error{
                functionError(error)
            }
        }, withErroBlock: {error in
            functionError(error)
        })
    }
    
    func getAuthToken(withParams params: [String : String], withCompletionBlock functionOK:@escaping((String) -> Void), functionError :@escaping((Error) -> Void)){
        makeRequest(url: apiURLProvider.authURL(), withMethod: .post, withParams: params, withCompletionBlock: { response, _ in
            guard let dataDict = response as? [String : Any] else { return }
            guard let token = dataDict[IGConstants.ParamsKeys.accessTokenKey] as? String else { return }
            functionOK(token)
        }, withErroBlock: {error in
            functionError(error)
        })
    }
    
    func getLongLiveToken(withParams params: [String : String], functionOK :@escaping((String) -> Void), functionError :@escaping ((Error) -> Void)){
        
        
        makeRequest(url: apiGraphURLProvider.tokenURL(), withMethod: .get, withParams: params, withCompletionBlock: {response, _ in
            guard let responseDict = response as? [String : Any] else { return }
            guard let token = responseDict[IGConstants.ParamsKeys.accessTokenKey] as? String else { return }
            functionOK(token)
        }, withErroBlock: functionError)
    }
    
    func refreshToken(withParams params: [String : String], functionOK :@escaping(() -> Void), functionError :@escaping((Error) -> Void)){
        makeRequest(url: apiGraphURLProvider.refreshToken(), withMethod: .get, withParams: params, withCompletionBlock: {response, _ in
            let responseDict = response as? [String : Any] ?? [:]
            functionOK()
        }, withErroBlock: functionError)
    }
    
    func getUserInfo(withParams params: [String : String], withCompletionBlock functionOK:@escaping((IGUserDTO) -> Void), functionError :@escaping((Error) -> Void)){
        makeRequest(url: apiGraphURLProvider.userURL(), withMethod: .get, withParams: params, withCompletionBlock: {response, _ in
            let responseDict = response as? [String : Any] ?? [:]
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
}
