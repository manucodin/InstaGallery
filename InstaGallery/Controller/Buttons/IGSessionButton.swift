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
        if let _  = IGManagerUtils.getUserIdentifier(){
            setTitle(logoutText, for: .normal)
            addTarget(self, action: #selector(login), for: .touchUpInside)
        }else{
            setTitle(loginText, for: .normal)
            addTarget(self, action: #selector(login), for: .touchUpInside)
        }
        
        setTitleColor(.white, for: .normal)
        backgroundColor = .red
    }
    
    @objc private func login(){
        if let loginFunction = self.functionLogin{
            loginFunction()
        }
    }
    
    @objc private func logout(){
        IGManagerUtils.logoutUser()
        configureView()
        
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
}
