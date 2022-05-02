//
//  AuthController.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit
import WebKit

class AuthController: UIViewController {
    
    internal var presenter: AuthPresenterInterface?
    internal var completionCallback :(() -> Void)?

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = presenter
            webView.allowsBackForwardNavigationGestures = false
            webView.configuration.websiteDataStore = .nonPersistent()
        }
    }

    init() {
        #if SWIFT_PACKAGE
        super.init(nibName: String(describing: AuthController.self), bundle: Bundle.module)
        #else
        super.init(nibName: String(describing: IGAuthController.self), bundle: Bundle(for: IGAuthController.self))
        #endif
    }
    
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        presenter?.load()
    }
    
    private func configureNavigationBar(){
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: .didTapDismiss
        )
        
        navigationItem.leftBarButtonItem = closeButton
    }
}

extension AuthController: AuthControllerInterface {
    func setupView() {
        configureNavigationBar()
    }
    
    func loadRequest(request: URLRequest) {
        webView.load(request)
    }
    
    func didLoadUser(user: User) {
        completionCallback?()
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AuthController {
    @objc internal func dismissController(_ sender: AnyObject){
        dismissView()
    }
}

internal extension Selector {
    static let didTapDismiss = #selector(AuthController.dismissController(_:))
}
