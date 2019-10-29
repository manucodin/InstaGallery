//
//  IGAuthPresenter.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation

class IGAuthPresenter{
    
    let manager = IGManager()
    
    weak var controller :IGAuthorizeController!
    
    init(controller :IGAuthorizeController){
        self.controller = controller
        self.checkUser()
    }
    
    private func checkUser(){
        if(IGManagerUtils.getUserToken() != nil){
            self.controller.view.alpha = 0
            return
        }
        self.controller.view.alpha = 1
    }
    
    func authUser(withCode code :String, withCompletionBlock functionOK:@escaping(() -> Void), functionError :@escaping((Error) -> Void)){
        manager.getAuthToken(withAuthCode: code, withCompletionBlock: functionOK, functionError: functionError)
    }
}
