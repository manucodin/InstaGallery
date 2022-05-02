//
//  RequestHeaders.swift
//  InstaGallery
//
//  Created by Manuel Rodriguez on 26/3/22.
//  Copyright © 2022 MRodriguez. All rights reserved.
//


import Foundation

internal struct RequestHeaders {
    internal static var defaultHeaders: [String: String] {
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
    }
}
