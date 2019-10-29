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
        
    var completionCallback :(() -> Void)!
    
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
        if let url = URL(string: String(format: URL_FORMAT, appID, redirectURI)){
            webView.load(URLRequest(url: url))
        }
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
    }
    
    func configureCallback(functionCallback :@escaping(() -> Void)){
        self.completionCallback = functionCallback
    }
    
    @objc private func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func authUser(withCode code :String){
        presenter.authUser(withCode: code, withCompletionBlock: {
            self.completionCallback()
        }, functionError: {error in
            debugPrint(error.localizedDescription)
            self.dismissController()
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
