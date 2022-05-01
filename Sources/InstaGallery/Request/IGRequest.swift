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

    func getUserGallery(withParams params: [String : String], completionHandler: @escaping ((Result<IGGalleryDTO, IGError>) -> Void)){
        makeRequest(url: apiGraphURLProvider.mediaURL, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
    
    func getUserImage(withIdentifier identifier :String, withParams params: [String : String], completionHandler: @escaping ((Result<IGMediaDTO?, IGError>) -> Void)) {
        let url = apiGraphURLProvider.API_GRAPH_INSTRAGRAM.appendingPathComponent(identifier)
        makeRequest(url: url, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
    
    func getAuthToken(withParams params: [String : String], completionHandler: @escaping ((Result<IGAuthenticationDTO, IGError>) -> Void)){
        makeRequest(url: apiURLProvider.authURL, withMethod: .post, withParameters: params, completionHandler: completionHandler)
    }
    
    func getLongLiveToken(withParams params: [String : String], completionHandler: @escaping ((Result<IGAuthenticationDTO, IGError>) -> Void)){
        makeRequest(url: apiGraphURLProvider.tokenURL, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
    
    func refreshToken(withParams params: [String : String], completionHandler: @escaping ((Result<IGAuthenticationDTO, IGError>) -> Void)){
        makeRequest(url: apiGraphURLProvider.refreshToken, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
    
    func getUserInfo(withParams params: [String : String], completionHandler: @escaping ((Result<IGUserDTO, IGError>) -> Void)) {
        makeRequest(url: apiGraphURLProvider.userURL, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
}
