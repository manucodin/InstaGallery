import UIKit

@objc public class InstaGallery: NSObject {    
    @objc public static func gallery(withDelegate delegate: GalleryDelegate? = nil) -> GalleryController {
        let galleryController = GalleryFactory.gallery()
        galleryController.delegate = delegate
        
        return galleryController
    }
}
