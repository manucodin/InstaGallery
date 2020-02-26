//
//  IGButton.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 20/01/2020.
//  Copyright © 2020 MRodriguez. All rights reserved.
//

import UIKit

public protocol IGSessionDelegate :class{
    func igSessionLogged(user :IGUser)
    func igSessionDisconnected()
}

public class IGSessionButton: UIButton {

    public weak var delegate :IGSessionDelegate?
    
    private var functionLogin   :(() -> Void)!
    private var functionLogout  :(() -> Void)!
    
    private weak var currentController :UIViewController?
    
    public var logoutText = "logout"{
        didSet{
            configureStatus()
        }
    }
    public var loginText = "login"{
        didSet{
            configureStatus()
        }
    }
    
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
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height/2
        
        if let image = imageView{
            let padding = 20.0
            let width = image.frame.size.width + 10
            imageEdgeInsets = UIEdgeInsets(top: 5, left: CGFloat(padding), bottom: 5, right: bounds.size.width - 40)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: width, bottom: 0, right: width)
        }
    }
    
    
    private func configureView(){
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        configureStatus()
    }
    
    private func configureStatus(){
        if let _  = IGManagerUtils.getUserIdentifier(){
            setTitle(logoutText, for: .normal)
            removeTarget(self, action: #selector(login), for: .touchUpInside)
            addTarget(self, action: #selector(logout), for: .touchUpInside)
        }else{
            setTitle(loginText, for: .normal)
            removeTarget(self, action: #selector(logout), for: .touchUpInside)
            addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    
    @objc private func login(){
        guard let controller = currentController else{
            return
        }
        
        let authController = IGAuthorizeController()
        authController.configureCallback(functionCallback: {[weak self] user in
            if let strongSelf = self{
                if let loginFunction = strongSelf.functionLogin{
                    loginFunction()
                }else{
                    strongSelf.delegate?.igSessionLogged(user: user)
                }
                
                authController.dismiss(animated: true, completion: nil)
                strongSelf.configureStatus()
            }
        })
        let navController = UINavigationController(rootViewController: authController)
        controller.present(navController, animated: true, completion: nil)
    }
    
    @objc private func logout(){
        IGManagerUtils.logoutUser()
        configureStatus()
        
        if let logoutFunction = self.functionLogout{
            logoutFunction()
        }else{
            self.delegate?.igSessionDisconnected()
        }
    }
    
    public func configureLoginCallback(functionCallback :@escaping (() -> Void)){
        self.functionLogin = functionCallback
    }
    
    public func configureLogoutCallback(functionCallback :@escaping (() -> Void)){
        self.functionLogout = functionCallback
    }
    
    public func showInController(_ controller :UIViewController){
        self.currentController = controller
    }
}
