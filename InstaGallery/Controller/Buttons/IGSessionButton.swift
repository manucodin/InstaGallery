//
//  IGButton.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 20/01/2020.
//  Copyright © 2020 MRodriguez. All rights reserved.
//

import UIKit

public class IGSessionButton: UIButton {

    private var functionLogin   :(() -> Void)!
    private var functionLogout  :(() -> Void)!
    
    private var currentController :UIViewController?
    
    public var logoutText = "logout"{
        didSet{
            configureView()
        }
    }
    public var loginText = "login"{
        didSet{
            configureView()
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
    }
    
    
    private func configureView(){
        setImage(UIImage(named: "instagram"), for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
    }
    
    private func configureStatus(){
        if let _  = IGManagerUtils.getUserIdentifier(){
            setTitle(logoutText, for: .normal)
            addTarget(self, action: #selector(logout), for: .touchUpInside)
        }else{
            setTitle(loginText, for: .normal)
            addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    
    @objc private func login(){
        guard let controller = currentController else{
            return
        }
        
        let authController = IGAuthorizeController()
        authController.configureCallback(functionCallback: {
           
            if let loginFunction = self.functionLogin{
                loginFunction()
            }
            
            authController.dismiss(animated: true, completion: nil)
            
            self.configureStatus()
            
        })
        let navController = UINavigationController(rootViewController: authController)
        controller.present(navController, animated: true, completion: nil)
    }
    
    @objc private func logout(){
        IGManagerUtils.logoutUser()
        configureStatus()
        
        if let logoutFunction = self.functionLogout{
            logoutFunction()
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
