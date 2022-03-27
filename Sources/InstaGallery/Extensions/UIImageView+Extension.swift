//
//  UIImageView+Extension.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 27/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func imageFromURL(url: URL) {
        self.image = nil
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in

            if let requestError = error{
                debugPrint(requestError)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }
}
