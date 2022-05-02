//
//  Request.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

class Request :BaseRequest{
    
    private let apiURLProvider = AuthURLProvider()
    private let apiGraphURLProvider = APIURLProvider()

    func getUserGallery(withParams params: [String : String], completionHandler: @escaping ((Result<GalleryDTO, InstaGalleryError>) -> Void)){
        makeRequest(url: apiGraphURLProvider.mediaURL, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
    
    func getUserImage(withIdentifier identifier :String, withParams params: [String : String], completionHandler: @escaping ((Result<MediaDTO?, InstaGalleryError>) -> Void)) {
        let url = apiGraphURLProvider.API_GRAPH_INSTRAGRAM.appendingPathComponent(identifier)
        makeRequest(url: url, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
    
    func getAuthToken(withParams params: [String : String], completionHandler: @escaping ((Result<AuthenticationDTO, InstaGalleryError>) -> Void)){
        makeRequest(url: apiURLProvider.authURL, withMethod: .post, withParameters: params, completionHandler: completionHandler)
    }
    
    func getLongLiveToken(withParams params: [String : String], completionHandler: @escaping ((Result<AuthenticationDTO, InstaGalleryError>) -> Void)){
        makeRequest(url: apiGraphURLProvider.tokenURL, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
    
    func refreshToken(withParams params: [String : String], completionHandler: @escaping ((Result<AuthenticationDTO, InstaGalleryError>) -> Void)){
        makeRequest(url: apiGraphURLProvider.refreshToken, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
    
    func getUserInfo(withParams params: [String : String], completionHandler: @escaping ((Result<UserDTO, InstaGalleryError>) -> Void)) {
        makeRequest(url: apiGraphURLProvider.userURL, withMethod: .get, withParameters: params, completionHandler: completionHandler)
    }
}
