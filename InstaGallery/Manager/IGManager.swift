//
//  IGManager.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

class IGManager{
            
    let request = IGRequest()
    
    func getAuthToken(withAuthCode code :String, withCompletionBlock functionOK:@escaping(() -> Void), functionError :@escaping((Error) -> Void)){
        request.getAuthToken(authCode: code, withCompletionBlock: {
            self.getUserInfo(withCompletionBlock: functionOK, functionError: functionOK)
        }, functionError: functionError)
    }
    
    private func getUserInfo(withCompletionBlock functionOK :@escaping(() -> Void), functionError :@escaping(() -> Void)){
        request.getUserInfo(withCompletionBlock: functionOK, functionError: functionOK)
    }
    
    func getUserGallery(withLastItem lastItem:String? = nil, withCompletionBlock functionOK:@escaping(([IGImageCover]?, String?) -> Void), errorBlock functionError:@escaping((Error) -> Void)){
        request.getUserGallery(nextPage: lastItem, withCompletionBlock: functionOK, functionError: functionError)
    }
    
    func getImage(withIdentifier identifier :String, withCompletionBlock functionOK :@escaping((UIImage?) -> Void), functionError :@escaping((Error) -> Void)){
        request.getUserImage(withIdentifier: identifier, withCompletionBlock: functionOK, errorBlock: functionError)
    }
}
