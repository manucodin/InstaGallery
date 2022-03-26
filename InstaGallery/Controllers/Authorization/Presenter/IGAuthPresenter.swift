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
    
    private func load() {
        interactor?.generateAuthRequest()
    }
    
//    let manager = IGManager()
//
//    weak var controller :IGAuthController!
//
//    init(controller :IGAuthController){
//        self.controller = controller
//        self.checkUser()
//    }
//
//    private func checkUser(){
//        if(IGManagerUtils.getUserToken() != nil){
//            self.controller.view.alpha = 0
//            return
//        }
//        self.controller.view.alpha = 1
//    }
//
//    func authUser(withCode code :String, withCompletionBlock functionOK:@escaping((IGUser) -> Void), functionError :@escaping((Error) -> Void)){
//        manager.getAuthToken(withAuthCode: code, withCompletionBlock: functionOK, functionError: functionError)
//    }
}

extension IGAuthPresenter: IGAuthPresenterInterface {
    func viewLoaded() {
        view?.setupView()
        load()
    }
    
    func dismiss() {
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

extension IGAuthPresenter: IGAuthInteractorOutput {
    func didGenerateAuthRequest(request: URLRequest) {
        view?.loadRequest(request: request)
    }
    
    func didAuthenticateUser(user: IGUser) {
        view?.didLoadUser(user: user)
    }
    
    func didGetError(error: Error) {
        debugPrint(error)
        routing?.dismiss()
    }
}
