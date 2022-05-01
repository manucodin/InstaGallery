//
//  IGDataSourceInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol IGDataSourceInterface {    
    func authenticate(withUserCode userCode: String, withCompletionBlock functionOK: @escaping ((IGUserDTO) -> Void), functionError: @escaping ((Error) -> Void))
    func getUserGallery(withLastItem lastItem:String?, withCompletionBlock functionOK:@escaping(([IGMediaDTO], String?) -> Void), errorBlock functionError:@escaping((Error) -> Void))
    func getImage(withIdentifier identifier :String, withCompletionBlock functionOK :@escaping((IGMediaDTO?) -> Void), functionError :@escaping((Error) -> Void))
}
