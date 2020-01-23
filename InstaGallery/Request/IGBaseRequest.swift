//
//  IGBaseRequest.swift
//  WeFish
//
//  Created by Manuel Rodríguez Sebastián on 24/10/2019.
//  Copyright © 2019 inup. All rights reserved.
//

import Foundation
//import Alamofire

private let IG_PATH = "https://api.instagram.com/"
private let IG_BASIC_PATH = "https://graph.instagram.com/"

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
    
    func makeRequest(to path :String, withMethod method :RequestMethod, withParams params :[String : Any]? = nil, withCompletionBlock functionOK:@escaping((Any, Any) -> Void), withErroBlock functionError:@escaping((Error) -> Void)){
        
        BASE_URL = IG_PATH
        
        return request(to: path, withMethod: method, withParams: params, withCompletionBlock: functionOK, withErroBlock: functionError)
    }
    
    func makeBasicRequest(to path :String, withMethod method :RequestMethod, withParams params :[String : Any]? = nil, withCompletionBlock functionOK:@escaping((Any, Any) -> Void), withErroBlock functionError:@escaping((Error) -> Void)){
        
        BASE_URL = IG_BASIC_PATH
        
        return request(to: path, withMethod: method, withParams: params, withCompletionBlock: functionOK, withErroBlock: functionError)
    }
    
    private func request(to path :String, withMethod method :RequestMethod, withParams params :[String : Any]? = nil, withCompletionBlock functionOK:@escaping((Any?, Any?) -> Void), withErroBlock functionError:@escaping((Error) -> Void)){
        
        if let url = URL(string: BASE_URL+path){
            
            session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)

            var requestData :Data?
            var request :URLRequest!
            if let requestParams = params, method == .get, let urlFormated = URL(string: String(format: "%@?%@", url.absoluteString, requestParams.paramsString())){
                request = URLRequest(url: urlFormated)
            }else{
                request = URLRequest(url: url)
                if let requestParams = params{
                    let jsonString = requestParams.paramsString()
                    requestData = jsonString.data(using: .utf8)
                }
                request.httpBody = requestData
            }
            
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
        
            let task = session.dataTask(with: request, completionHandler: {data, response, error in
                guard let dataRequest = data, error == nil else{
                    functionError(self.errorURL())
                    return
                }
                
                if let requestError = error{
                    functionError(requestError)
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
                                if(error.code == 190 && path != "refresh_access_token"){
                                    if(self.tryCounter < 3){
                                        self.tryCounter += 1
                                        IGRequest().refreshToken(functionOK: {
                                            self.request(to: path, withMethod: method, withParams: params,withCompletionBlock: functionOK, withErroBlock: functionError)
                                        }, functionError: functionError)
                                    }else{
                                        self.tryCounter = 0
                                        functionError(error)
                                    }
                                }else{
                                    functionError(error)
                                }
                            }else{
                                functionError(self.errorURL())
                            }
                        }
                    }
                }catch let error{
                    functionError(error)
                }
            })
            task.resume()
        }else{
            functionError(errorURL())
        }
    }
    
    private func errorURL() -> Error{
        let error = NSError(domain: "com.igRequest", code: 0, userInfo: nil)
        return error
    }
}

extension IGBaseRequest :URLSessionTaskDelegate{
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(request)
    }
}
