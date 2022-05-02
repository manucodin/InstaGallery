# InstaGallery
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square) [![Swift](https://img.shields.io/badge/swift-5.0-red?style=flat-square)](https://cocoapods.org/pods/InstaGallery) [![Platform](https://img.shields.io/badge/platform-ios-blue?style=flat-square)](https://cocoapods.org/pods/InstaGallery) 

InstaGallery is an easy way to access your Instagram account and get your gallery and get his media in a few steps.

## How to use
1. You need a Facebook Developer account, go to [Facebook Developer](https://developers.facebook.com/) and create a new account if you haven't yet
2. Create a new Facebook application following the steps that appear on the official web site [Create Facebook Application for Instagram](https://developers.facebook.com/docs/instagram-basic-display-api/getting-started)
3. Open your `Info.plist`
4. Set a new key with name `InstagramClientId` and set your Instagram App Id in this key
5. Set a new key with name `InstagramRedirectURI` and set with your Instagram App Redirect URI
6. Set one more key with name `InstagramClientSecret` with the Instagram App Secret.
7. Init `GalleryController` with method `InstaGallery.gallery`. If you need retrieve the media selected, do you need set `GalleryDelegate` delegate with the optinal parameters `delegate`. For example
```swift
        let galleryController = InstaGallery.gallery(withDelegate: self)
        let navigationController = UINavigationController(rootViewController: galleryController)
        present(navigationController, animated: true, completion: nil)
```
8. Enjoy! 🎉

## CocoaPod
InstaGallery is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InstaGallery'
pod install
```

## Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding Alamofire as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/MRodSebastian/InstaGallery.git", .upToNextMajor(from: "0.4.0"))
]
```

## Contribute

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create pull request

## Who made this?
- Manu Rodriguez ([@MRBenzex](https://twitter.com/mrbenzex))
