//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import XCTest
import Nimble
@testable import InstaGallery

final class AuthenticationInteractorTest: XCTestCase {
    var sut: AuthInteractor!
    
    private let bundleDataSourceMock = BundleDataSourceMock()
    private let userDataSourceMock = UserDataSourceMock()
    private let instagramDataSourceMock = InstagramDataSourceMock()
    private let outputMock = AuthInteractorOutputMock()
    
    override func setUp() {
        super.setUp()
        
        sut = AuthInteractor(
            bundleDataSource: bundleDataSourceMock,
            userDataSource: userDataSourceMock,
            instagramDataSource: instagramDataSourceMock
        )
        
        sut.output = outputMock
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testGenerateAuthRequest() {
        bundleDataSourceMock.stubbedAppID = "appId"
        bundleDataSourceMock.stubbedRedirectURI = "redirectURI"
        
        let clientIDKey = Constants.ParamsKeys.clientIDKey
        let redirectURIKey = Constants.ParamsKeys.redirectURIKey
        let expectedURLRequest = sut.authRequest
        
        expect(expectedURLRequest).notTo(beNil())
        expect(expectedURLRequest?.url?.queryParameters?[clientIDKey]).notTo(beNil())
        expect(expectedURLRequest?.url?.queryParameters?[clientIDKey]).to(equal(bundleDataSourceMock.appID))
        expect(expectedURLRequest?.url?.queryParameters?[redirectURIKey]).notTo(beNil())
        expect(expectedURLRequest?.url?.queryParameters?[redirectURIKey]).to(equal(bundleDataSourceMock.redirectURI))
    }
    
    func testAuthenticateCode() {
        let testCode = "testCode"
        let userDTO = IGUserDTOMother.user()
        let authResult = (Result<UserDTO, InstaGalleryError>.success(userDTO), ())
        
        instagramDataSourceMock.stubbedAuthenticateCompletionHandlerResult = authResult
        sut.authenticate(userCode: testCode)
        
        expect(self.outputMock.invokedDidAuthenticateUser).to(beTrue())
    }
    
    func testAuthenticateError() {
        let testCode = "testCode"
        let authError = (Result<UserDTO, InstaGalleryError>.failure(.invalidUser), ())
        
        instagramDataSourceMock.stubbedAuthenticateCompletionHandlerResult = authError
        sut.authenticate(userCode: testCode)
        
        expect(self.outputMock.invokedDidGetError).to(beTrue())
    }
}
