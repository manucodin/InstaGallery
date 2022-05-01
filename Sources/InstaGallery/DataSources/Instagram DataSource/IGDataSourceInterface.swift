//
//  IGDataSourceInterface.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

internal protocol IGDataSourceInterface {    
    func authenticate(withUserCode userCode: String, completionHandler: @escaping ((Result<IGUserDTO, IGError>) -> Void))
    func getUserGallery(withLastItem lastItem: String?, completionHandler: @escaping ((Result<IGGalleryDTO, IGError>) -> Void))
    func getImage(withIdentifier identifier: String, completionHandler: @escaping ((Result<IGMediaDTO?, IGError>) -> Void))
}
