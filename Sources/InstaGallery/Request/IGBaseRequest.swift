//
//  IGBaseRequest.swift
//  WeFish
//
//  Created by Manuel Rodríguez Sebastián on 24/10/2019.
//  Copyright © 2019 inup. All rights reserved.
//

import Foundation

enum RequestMethod :String{
    case get    = "GET"
    case post   = "POST"
}

class IGBaseRequest :NSObject{
    
    private var tryCounter = 0
    
    private var session : URLSession!
    
    private var BASE_URL = ""
    private let headers = [
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
    ]
    
    private let userDataSource = IGUserDefaultsDataSourceImp()
    
    func makeRequest(url: URL, withMethod method :RequestMethod, withParams params :[String : Any]? = nil, withCompletionBlock functionOK:@escaping((Any, Any) -> Void), withErroBlock functionError:@escaping((IGError) -> Void)){
        return request(url: url, withMethod: method, withParams: params, withCompletionBlock: functionOK, withErroBlock: functionError)
    }
    
    private func request(url :URL, withMethod method :RequestMethod, withParams params :[String : Any]? = nil, withCompletionBlock functionOK:@escaping((Any?, Any?) -> Void), withErroBlock functionError:@escaping((IGError) -> Void)){
        
        guard let generatedRequest = generateURLRequest(withMethod: method, url: url, withParams: params) else { return }
                
        var request = generatedRequest
        request.allHTTPHeaderFields = headers
        
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)

        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let dataRequest = data, error == nil else{
                functionError(.invalidRequest)
                return
            }
            
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataRequest, options: JSONSerialization.ReadingOptions())
                if let responseRequest = response as? HTTPURLResponse{
                    let responseCode = responseRequest.statusCode
                    switch responseCode{
                    case 200...299:
                        functionOK(jsonResponse, nil)
                    default:
                        if let errorRespose = jsonResponse as? [String : Any], let errorDict = errorRespose["error"] as? [String : Any]{
                            let errorCode = errorDict["code"] as? Int ?? responseCode
                            let errorMessage = errorDict["message"] as? String ?? "error"
                            
                            let errorInfo :[String : Any] = [
                                NSLocalizedDescriptionKey : errorMessage
                            ]
                            
                            let error = NSError(domain: "com.igRequest", code: errorCode, userInfo: errorInfo)
                            if(error.code == 190){
                                if(self.tryCounter < 3){
                                    self.tryCounter += 1
                                    self.refreshToken(withCompletion: { [weak self] newToken in
                                        guard let welf = self else { return }
                                        guard let currentUser = welf.userDataSource.getUser() else { return }
                                        let updatedUser = currentUser.updating(token: newToken)
                                        
                                        do {
                                            try welf.userDataSource.saveUser(user: updatedUser)
                                            
                                            var newParams = params
                                            if newParams?["access_token"] != nil {
                                                newParams?["access_token"] = newToken
                                            }
                                            
                                            welf.request(url: url, withMethod: method, withParams: newParams, withCompletionBlock: functionOK, withErroBlock: functionError)
                                        } catch {
                                            functionError(.invalidUser)
                                        }
                                        
                                    }, errorBlock: functionError)
                                }else{
                                    self.tryCounter = 0
                                    functionError(.invalidUser)
                                }
                            }else{
                                functionError(.unexpected(code: error.code))
                            }
                        }else{
                            functionError(.invalidResponse)
                        }
                    }
                }
            }catch {
                functionError(.invalidRequest)
            }
        })
        
        task.resume()
    }
    
    private func refreshToken(withCompletion completion: @escaping ((String) -> Void), errorBlock: @escaping ((IGError) -> Void)) {
        guard let token = userDataSource.userToken else { return }
        let params :[String : String] = [
            "grant_type": "ig_refresh_token",
            "access_token": token
        ]
        IGRequest().refreshToken(withParams: params, functionOK: { newToken in
            completion(newToken)
        }, functionError: errorBlock)
    }
    
    private func generateURLRequest(withMethod method: RequestMethod, url: URL, withParams params: [String : Any]?) -> URLRequest? {
        if method == .get, let requestParams = params {
            guard let url = URL(string: String(format: "%@?%@", url.absoluteString, requestParams.paramsString())) else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            return request
        } else {
            var request = URLRequest(url: url)
            if let requestParams = params {
                let jsonString = requestParams.paramsString()
                let requestData = jsonString.data(using: .utf8)
                request.httpBody = requestData
            }
            request.httpMethod = method.rawValue
            return request
        }
    }
}

extension IGBaseRequest :URLSessionTaskDelegate{
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(request)
    }
}
