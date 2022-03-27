//
//  IGManagerUtils.swift
//  InstaGallery
//
//  Created by Manuel Rodríguez Sebastián on 28/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class IGManagerUtils{
    class func logoutUser(){
        IGManagerUtils.cleanAllCookies()
    }
    
    public class func cleanAllCookies(){
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: {records in
            records.forEach{record in
                if(record.displayName.contains("instagram")){
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                        print("Deleted: " + record.displayName);
                    })
                }
            }
        })
    }
}
