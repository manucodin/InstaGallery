//
//  IGAuthorizeController.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit
import WebKit

private let URL_FORMAT = "https://www.instagram.com/oauth/authorize?app_id=%@&redirect_uri=%@&scope=user_profile,user_media&response_type=code"

class IGAuthorizeController: UIViewController {
    
    private let bundle = Bundle.main

    private var presenter :IGAuthPresenter!
        
    var completionCallback :((IGUser) -> Void)!
        
    private lazy var appID :String = {
        return bundle.object(forInfoDictionaryKey: "InstagramClientId") as? String ?? ""
    }()
    
    private lazy var redirectURI :String = {
        return bundle.object(forInfoDictionaryKey: "InstagramRedirectURI") as? String ?? ""
    }()
    
    @IBOutlet weak var webView: WKWebView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = IGAuthPresenter(controller: self)
        
        configureView()
    }
    
    private func configureView(){
        configureNavigationBar()
        configureWebView()
    }
    
    private func configureNavigationBar(){
        navigationItem.title = NSLocalizedString("instagram", comment: "")
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    private func configureWebView(){
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        webView.configuration.websiteDataStore = .nonPersistent()
        
        if let url = URL(string: String(format: URL_FORMAT, appID, redirectURI)){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func configureCallback(functionCallback :@escaping((IGUser) -> Void)){
        self.completionCallback = functionCallback
    }
    
    @objc private func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func authUser(withCode code :String){
        presenter.authUser(withCode: code, withCompletionBlock: {[weak self] user in
            if let strongSelf = self{
                strongSelf.completionCallback(user)
            }
        }, functionError: {[weak self] error in
            if let strongSelf = self{
                strongSelf.dismissController()
            }
        })
    }
}

extension IGAuthorizeController :WKNavigationDelegate{
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void){
        if(navigationAction.navigationType == .other){
            if let redirectURL = navigationAction.request.url, redirectURL.absoluteString.contains(self.redirectURI), let code = redirectURL.queryParameters?["code"]{
                decisionHandler(.cancel)
                self.authUser(withCode: code)
                return
            }else{
                decisionHandler(.allow)
            }
        }else{
            decisionHandler(.allow)
        }
    }
}
