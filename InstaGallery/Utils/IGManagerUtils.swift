//
//  IGManagerUtils.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

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
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}

extension Dictionary{
    
    func paramsString() -> String {
        var paramsString = [String]()
        for (key, value) in self {
            guard let stringValue = value as? String, let stringKey = key as? String else {
                return ""
            }
            
            let normalizeValue = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
            let normalizeKey = stringKey.trimmingCharacters(in: .whitespacesAndNewlines)
            
            paramsString += [normalizeKey + "=" + "\(normalizeValue)"]

        }
        
        return (paramsString.isEmpty ? "" : paramsString.joined(separator: "&"))
    }
}

extension Error{
    var code        :Int{return (self as NSError).code}
    var domain      :String{return (self as NSError).domain}
    var message     :String{return (self as NSError).localizedDescription}
}

extension UIImageView {
    
    public func imageFromURL(url: URL) {
        self.image = nil
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in

            if let requestError = error{
                debugPrint(requestError)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }
}
