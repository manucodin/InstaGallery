//
//  IGManagerUtils.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class IGManagerUtils{

    private static let IG_USERID_KEY = "IG_USER"
    private static let IG_TOKEN_KEY = "IG_TOKEN"
    private static let IG_USER_NAME = "IG_USER_NICK"
    
    //MARK: - SAVE user ID
    class func saveUserIdentifier(identifier :Int){
        UserDefaults.standard.set(identifier, forKey: IG_USERID_KEY)
    }
    
    //MARK: - SAVE access token
    class func saveAccessToken(token :String){
        UserDefaults.standard.set(token, forKey: IG_TOKEN_KEY)
    }
    
    //MARK: - SAVE user name
    class func saveUserName(name :String){
        UserDefaults.standard.set(name, forKey: IG_USER_NAME)
    }
    
    //MARK: - GET user ID
    class func getUserIdentifier() -> Int?{
        return UserDefaults.standard.object(forKey: IG_USERID_KEY) as? Int
    }
    
    //MARK: - GET access token
    class func getUserToken() -> String?{
        return UserDefaults.standard.object(forKey: IG_TOKEN_KEY) as? String
    }
    
    //MARK: - GET user name
    class func getUserName() -> String?{
        return UserDefaults.standard.object(forKey: IG_USER_NAME) as? String
    }
    
    class func logoutUser(){
        UserDefaults.standard.removeObject(forKey: IG_TOKEN_KEY)
        UserDefaults.standard.removeObject(forKey: IG_USERID_KEY)
        UserDefaults.standard.removeObject(forKey: IG_USER_NAME)
        IGManagerUtils.cleanAllCookies()
    }
    
    public class func cleanAllCookies(){
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: {records in
            records.forEach{record in
                if(record.displayName.contains("instagram")){
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                        print("Deleted: " + record.displayName);
                    })
                }
            }
        })
    }
}
