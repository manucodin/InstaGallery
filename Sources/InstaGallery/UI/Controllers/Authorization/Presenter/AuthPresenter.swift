//
//  AuthPresenter.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import WebKit

class AuthPresenter: NSObject {
    weak var view: AuthControllerInterface?
    var routing: AuthRoutingInterface?
    var interactor: AuthInteractorInput?
}

extension AuthPresenter: AuthPresenterInterface {
    func viewLoaded() {
        view?.setupView()
    }
    
    func load() {
        guard let authRequest = interactor?.authRequest else { return }
        
        view?.loadRequest(request: authRequest)
    }
    
    func dismiss() {
        routing?.dismiss()
    }
}

extension AuthPresenter: AuthInteractorOutput {
    func didAuthenticateUser(user: User) {
        view?.didLoadUser(user: user)
        routing?.dismiss()
    }
    
    func didGetError(error: Error) {
        routing?.dismiss()
    }
}

extension AuthPresenter: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void){
        guard let code = navigationAction.request.url?.queryParameters?["code"] else {
            decisionHandler(.allow)
            return
        }
        
        decisionHandler(.cancel)
        interactor?.authenticate(userCode: code)
    }
}
