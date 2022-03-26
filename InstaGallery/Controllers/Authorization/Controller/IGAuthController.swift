//
//  IGAuthorizeController.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit
import WebKit

class IGAuthController: UIViewController {
    
    internal var presenter: IGAuthPresenterInterface?
    internal var completionCallback :((IGUser) -> Void)!

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.allowsBackForwardNavigationGestures = false
            webView.configuration.websiteDataStore = .nonPersistent()
        }
    }

    init() {
        super.init(nibName: String(describing: IGAuthController.self), bundle: Bundle(for: IGAuthController.self))
    }
    
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }
    
    private func configureNavigationBar(){
        navigationItem.title = NSLocalizedString("instagram", comment: "")

        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: .didTapDismiss
        )
        
        navigationItem.leftBarButtonItem = closeButton
    }

//    func authUser(withCode code :String){
//        presenter.authUser(withCode: code, withCompletionBlock: {[weak self] user in
//            if let strongSelf = self{
//                strongSelf.completionCallback(user)
//            }
//        }, functionError: {[weak self] error in
//            if let strongSelf = self{
//                strongSelf.dismissController()
//            }
//        })
//    }
}


extension IGAuthController: IGAuthControllerInterface {
    func setupView() {
        configureNavigationBar()
    }
    
    func loadRequest(request: URLRequest) {
        webView.navigationDelegate = presenter
        webView.load(request)
    }
    
    func didLoadUser(user: IGUser) {
        completionCallback(user)
    }
}

extension IGAuthController {
    @objc internal func dismissController(_ sender: AnyObject){
        self.dismiss(animated: true, completion: nil)
    }
}

internal extension Selector {
    static let didTapDismiss = #selector(IGAuthController.dismissController(_:))
}
