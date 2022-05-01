//
//  IGBaseRequest.swift
//  WeFish
//
//  Created by Manuel Rodríguez Sebastián on 24/10/2019.
//  Copyright © 2019 inup. All rights reserved.
//

import Foundation

class IGBaseRequest :NSObject{
    private var tryCounter = 0        
    private let userDataSource = IGUserDataSourceImp()
    
    func makeRequest<T: Encodable, V: Codable>(url: URL, withMethod method :RequestMethods, withParameters parameters :T, completionHandler: @escaping (Result<V, IGError>) -> Void){
        return request(url: url, method: method, withParameters: parameters, completionHandler: completionHandler)
    }
    
    private func request<T: Encodable, V: Codable>(url: URL, method: RequestMethods, withParameters parameters: T, completionHandler: @escaping (Result<V, IGError>) -> Void) {
        
        guard let request = generateRequest(url: url, method: method, withParamemters: parameters) else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let codable = try data.decoded() as V
                    completionHandler(.success(codable))
                } catch {
                    completionHandler(.failure(.invalidResponse))
                }
            default:
                self.manageError(url: url, withMethod: method, withParameters: parameters, response: httpResponse, data: data, completionHandler: completionHandler)
            }
        }
        task.resume()
    }
    
    private func generateRequest<T: Encodable>(url: URL, method: RequestMethods, withParamemters parameters: T) -> URLRequest? {
        guard let data = try? JSONEncoder().encode(parameters) else {
            return nil
        }
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : String] else {
            return nil
        }
        
        var authenticatedParams = dictionary
        if let userToken = userDataSource.userToken {
            authenticatedParams["access_token"] = userToken
        }
        
        switch method {
        case .get: return generateGetRequest(url: url, withParameters: authenticatedParams)
        case .post: return generatePostRequest(url: url, withParameters: authenticatedParams)
        }
    }
    
    private func generatePostRequest<T: Encodable>(url: URL, withParameters parameters: T) -> URLRequest? {
        guard let data = try? JSONEncoder().encode(parameters) else {
            return nil
        }
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : String] else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethods.post.rawValue
        request.allHTTPHeaderFields = RequestHeaders.defaultHeaders
        request.httpBody = dictionary.paramsString().data(using: .utf8)

        return request
    }
    
    private func generateGetRequest<T: Encodable>(url: URL, withParameters parameters: T) -> URLRequest? {
        guard let data = try? JSONEncoder().encode(parameters) else {
            return nil
        }
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : String] else {
            return nil
        }
        
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = dictionary.map{ URLQueryItem (name: $0.key, value: $0.value) }
        
        guard let urlFormated = components?.url else {
            return nil
        }
        
        var request = URLRequest(url: urlFormated)
        request.httpMethod = RequestMethods.get.rawValue
        request.allHTTPHeaderFields = RequestHeaders.defaultHeaders
        
        return request
    }
    
    private func manageError<T: Encodable, V: Codable>(url: URL, withMethod method :RequestMethods, withParameters parameters :T, response: HTTPURLResponse, data: Data, completionHandler: @escaping (Result<V, IGError>) -> Void) {
        switch response.statusCode {
        case 400:
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any] else {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            guard let code = jsonResponse["code"] as? Int else {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            switch code {
            case 190:
                self.expiredToken(url: url, method: method, withParameters: parameters, completionHandler: completionHandler)
            default:
                completionHandler(.failure(.unexpected(code: code)))
            }
        default:
            completionHandler(.failure(.unexpected(code: response.statusCode)))
        }
    }
    
    private func expiredToken<T: Encodable, V: Codable>(url: URL, method: RequestMethods, withParameters parameters: T, completionHandler: @escaping (Result<V, IGError>) -> Void) {
        guard tryCounter < 3 else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        if userDataSource.userToken == nil {
            completionHandler(.failure(.invalidUser))
            return
        }
        
        tryCounter += 1
        let params :[String : String] = [
            "grant_type": "ig_refresh_token",
        ]
        
        IGRequest().refreshToken(withParams: params) { [weak self] result in
            switch result {
            case .success(let authenticationDTO):
                guard let newToken = authenticationDTO.accessToken else {
                    completionHandler(.failure(.invalidUser))
                    return
                }
                
                guard let updatedUser = self?.userDataSource.getUser()?.updating(token: newToken) else {
                    completionHandler(.failure(.invalidUser))
                    return
                }
                
                do {
                    try self?.userDataSource.saveUser(user: updatedUser)
                    self?.tryCounter = 0
                    self?.request(url: url, method: method, withParameters: parameters, completionHandler: completionHandler)
                } catch {
                    completionHandler(.failure(.invalidUser))
                    return
                }
            case .failure(let error):
                self?.tryCounter = 0
                completionHandler(.failure(error))
            }
        }
    }
}

extension IGBaseRequest: URLSessionTaskDelegate{
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(request)
    }
}
