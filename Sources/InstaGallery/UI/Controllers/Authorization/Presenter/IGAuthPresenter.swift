//
//  IGAuthPresenter.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import WebKit

class IGAuthPresenter: NSObject {
    weak var view: IGAuthControllerInterface?
    var routing: IGAuthRoutingInterface?
    var interactor: IGAuthInteractorInput?
}

extension IGAuthPresenter: IGAuthPresenterInterface {
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

extension IGAuthPresenter: IGAuthInteractorOutput {
    func didAuthenticateUser(user: IGUser) {
        view?.didLoadUser(user: user)
        routing?.dismiss()
    }
    
    func didGetError(error: Error) {
        routing?.dismiss()
    }
}

extension IGAuthPresenter: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void){
        guard let code = navigationAction.request.url?.queryParameters?["code"] else {
            decisionHandler(.allow)
            return
        }
        
        decisionHandler(.cancel)
        interactor?.authenticate(userCode: code)
    }
}
