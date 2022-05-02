//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import Foundation
@testable import InstaGallery

internal struct IGCursorMother {
    internal static func cursor() -> CursorDTO {
        return CursorDTO(after: "cursorAfter", before: "cursorBefore")
    }
}
