//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import XCTest
import Nimble
@testable import InstaGallery

final class UserDataSourceTests: XCTestCase {
    
    var sut: IGUserDataSourceInterface!
    
    private let userMock = IGUserDTOMother.user()
    
    override func setUp() {
        super.setUp()
        
        sut = IGUserDataSourceImp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testSaveUser() {
        try? sut.saveUser(user: userMock)
        
        let expectedUser = sut.getUser()
        expect(expectedUser).notTo(beNil())
    }
    
    func testUserID() {
        try? sut.saveUser(user: userMock)
        
        let expectedID = sut.userID
        expect(expectedID).notTo(beNil())
        expect(expectedID).to(equal(userMock.id))
    }
    
    func testUserName() {
        try? sut.saveUser(user: userMock)
        
        let expectedName = sut.userName
        expect(expectedName).notTo(beNil())
        expect(expectedName).to(equal(userMock.username))
    }
    
    func testUserToken() {
        try? sut.saveUser(user: userMock)
        
        let expectedToken = sut.userToken
        expect(expectedToken).notTo(beNil())
        expect(expectedToken).to(equal(userMock.token))
    }
    
    func testIsUserLogged() {
        try? sut.saveUser(user: userMock)
        
        let expectedUserLogged = sut.isUserLogged
        expect(expectedUserLogged).to(beTrue())
    }
    
    func testClearAll() {
        sut?.clearAll()
        
        let expectedID = sut.userID
        let expectedUserName = sut.userName
        let expectedToken = sut.userToken
        let expectedUser = sut.getUser()
        
        expect(expectedID).to(beNil())
        expect(expectedUserName).to(beNil())
        expect(expectedToken).to(beNil())
        expect(expectedUser).to(beNil())
    }
    
}
