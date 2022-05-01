import UIKit

@objc public class InstaGallery: NSObject {
    @objc public static func gallery(withDelegate delegate: IGGalleryDelegate? = nil) -> IGGalleryController {
        let galleryController = IGGalleryFactory.gallery()
        galleryController.delegate = delegate
        
        return galleryController
    }
}
