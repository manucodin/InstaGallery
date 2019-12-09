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
    
    private static let authPath    = "oauth/access_token"
    private static let userMedia   = "me/media"
    private static let userNode    = "me"
    
    func getAuthToken(authCode code :String, withCompletionBlock functionOK:@escaping(() -> Void), functionError :@escaping((Error) -> Void)){
        let bundle = Bundle.main
        
        let parameters :[String : Any] = [
            "app_id" : bundle.object(forInfoDictionaryKey: "InstagramClientId") as? String ?? "",
            "app_secret" : bundle.object(forInfoDictionaryKey: "InstagramClientSecret") as? String ?? "",
            "grant_type" : "authorization_code",
            "redirect_uri" : bundle.object(forInfoDictionaryKey: "InstagramRedirectURI") as? String ?? "",
            "code" : code
        ]
        
        makeRequest(to: IGRequest.authPath, withMethod: .post, withParams: parameters, withCompletionBlock: {response, _ in
            let responseDict = response as? [String : Any] ?? [:]
            IGRequest.mapUserInfo(userInfo: responseDict)
            functionOK()
        }, withErroBlock: {error in
            functionError(error)
        })
    }
    
    func getUserInfo(withCompletionBlock functionOK:@escaping(() -> Void), functionError :@escaping(() -> Void)){
        let parameters :[String : Any] = [
            "fields" : "id,username",
            "access_token" : IGManagerUtils.getUserToken() ?? ""
        ]
        
        makeBasicRequest(to: IGRequest.userNode, withMethod: .get, withParams: parameters, withCompletionBlock: {response, _ in
            let responseDict = response as? [String : Any] ?? [:]
            IGRequest.mapUserInfo(userInfo: responseDict)
            functionOK()
        }, withErroBlock: {_ in
            functionOK()
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
    
    func getUserGallery(nextPage :String? = nil, withCompletionBlock functionOK:@escaping(([IGImageCover]?, String?) -> Void), functionError :@escaping((Error) -> Void)){
        var parameters :[String : Any] = [
            "fields" : "id,media_url,media_type",
            "access_token" : IGManagerUtils.getUserToken() ?? ""
        ]
        
        if let nextItem = nextPage{
            parameters["after"] = nextItem
        }
        
        makeBasicRequest(to: IGRequest.userMedia, withMethod: .get, withParams: parameters, withCompletionBlock: {response, _ in
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
    
    func getUserImage(withIdentifier identifier :String, withCompletionBlock functionOK:@escaping((UIImage?) -> Void), errorBlock functionError :@escaping((Error) -> Void)){
        
        let parameters :[String : Any] = [
            "fields" : "id,media_url,timestamp",
            "access_token" : IGManagerUtils.getUserToken() ?? ""
        ]
        
        makeBasicRequest(to: identifier, withMethod: .get, withParams: parameters, withCompletionBlock: {response, _ in
            do{
                let responseDict = response as? [String : Any] ?? [:]
                let jsonData = try JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
                let igImage = try JSONDecoder().decode(IGImage.self, from: jsonData)
                
                if let url = URL(string: igImage.urlString){
                    let data = try Data(contentsOf: url)
                    if let image = UIImage(data: data){
                        functionOK(image)
                    }else{
                        functionOK(nil)
                    }
                }else{
                    functionOK(nil)
                }
            }catch let error{
                functionError(error)
            }
        }, withErroBlock: {error in
            functionError(error)
        })
    }
}
