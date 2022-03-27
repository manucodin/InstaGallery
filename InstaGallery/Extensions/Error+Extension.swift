//
//  Error+Extension.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation

extension Error{
    var code        :Int{return (self as NSError).code}
    var domain      :String{return (self as NSError).domain}
    var message     :String{return (self as NSError).localizedDescription}
}
