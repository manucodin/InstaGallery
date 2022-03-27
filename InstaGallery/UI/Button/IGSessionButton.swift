//
//  IGButton.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 20/01/2020.
//  Copyright © 2020 MRodriguez. All rights reserved.
//

import UIKit

public class IGSessionButton: UIButton {

    public weak var delegate :IGSessionDelegate?
    
    public var logoutText = "Logout"
    public var loginText = "Login"
    
    private var functionLogin   :(() -> Void)?
    private var functionLogout  :(() -> Void)?
    
    private weak var currentController :UIViewController? {
        guard let viewController = getOwningViewController() else { return nil }
        
        return viewController
    }
    
    private var mode: IGSessionButtonStatus = .disconnected {
        didSet {
            switch mode {
            case .logged: configureLogged()
            case .disconnected: configureDisconnected()
            }
        }
    }
    
    private let userDataSource = IGUserDefaultsDataSourceImp()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureMode() {
        mode = userDataSource.isUserLogged ? .logged : .disconnected
    }
    
    private func configureView(){
        backgroundColor = .white
        configureMode()
    }
    
    private func configureLogged() {
        setTitle(logoutText, for: .normal)
        removeTarget(self, action: .didTapLogin, for: .touchUpInside)
        addTarget(self, action: .didTapLogout, for: .touchUpInside)
    }
    
    private func configureDisconnected() {
        setTitle(loginText, for: .normal)
        removeTarget(self, action: .didTapLogout, for: .touchUpInside)
        addTarget(self, action: .didTapLogin, for: .touchUpInside)
    }
    
    public func configureLoginCallback(functionCallback :@escaping (() -> Void)){
        self.functionLogin = functionCallback
    }
    
    public func configureLogoutCallback(functionCallback :@escaping (() -> Void)){
        self.functionLogout = functionCallback
    }
}

extension IGSessionButton {
    @objc internal func login(_ sender: AnyObject){
        guard let controller = currentController else{ return }
        
        let authController = IGAuthFactory.auth { [weak self] in
            guard let welf = self else { return }
            
            if let loginFunction = welf.functionLogin {
                loginFunction()
            } else {
                welf.delegate?.userLogged()
            }
            
            welf.configureMode()
        }
      
        let navController = UINavigationController(rootViewController: authController)
        controller.present(navController, animated: true, completion: nil)
    }
    
    @objc internal func logout(_ sender: AnyObject){
        IGManagerUtils.logoutUser()
        userDataSource.clearAll()
        
        configureMode()
        
        if let logoutFunction = self.functionLogout{
            logoutFunction()
        }else{
            self.delegate?.userDisconnected()
        }
    }
}

internal extension Selector {
    static let didTapLogin = #selector(IGSessionButton.login(_:))
    static let didTapLogout = #selector(IGSessionButton.logout(_:))
}

