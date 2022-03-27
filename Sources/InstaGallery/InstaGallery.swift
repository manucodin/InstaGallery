import UIKit

@objc public class InstaGallery: NSObject {
    @objc public static func openGallery(inViewController viewController: UIViewController, withDelegate delegate: IGGalleryDelegate? = nil) {
        let galleryController = IGGalleryFactory.gallery()
        galleryController.delegate = delegate
        
        let navigationController = UINavigationController(rootViewController: galleryController)
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
