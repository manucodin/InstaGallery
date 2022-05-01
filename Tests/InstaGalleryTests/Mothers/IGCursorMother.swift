//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

internal struct IGCursorMother {
    internal static func cursor() -> IGCursorDTO {
        return IGCursorDTO(after: "cursorAfter", before: "cursorBefore")
    }
}
