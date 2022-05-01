//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import XCTest
import Nimble
@testable import InstaGallery

final class UserDefaultsDataSourceTests: XCTestCase {
    
    var sut: IGUserDefaultsDataSourceInterface?
    
    private let userMock = IGUserDTOMother.user()
    
    override func setUp() {
        super.setUp()
        
        sut = IGUserDefaultsDataSourceImp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testSaveUser() {
        do {
            try sut?.saveUser(user: userMock)
        } catch {
            fail()
        }
        
        let expectedUser = sut?.getUser()
        expect(expectedUser).notTo(beNil())
    }
    
    func testUserID() {
        do {
            try sut?.saveUser(user: userMock)
        } catch {
            fail()
        }
        
        let expectedID = sut?.userID
        expect(expectedID).notTo(beNil())
        expect(expectedID).to(equal(userMock.id))
    }
    
    func testUserName() {
        do {
            try sut?.saveUser(user: userMock)
        } catch {
            fail()
        }
        
        let expectedName = sut?.userName
        expect(expectedName).notTo(beNil())
        expect(expectedName).to(equal(userMock.username))
    }
    
    func testUserToken() {
        do {
            try sut?.saveUser(user: userMock)
        } catch {
            fail()
        }
        
        let expectedToken = sut?.userToken
        expect(expectedToken).notTo(beNil())
        expect(expectedToken).to(equal(userMock.token))
    }
    
    func testIsUserLogged() {
        do {
            try sut?.saveUser(user: userMock)
        } catch {
            fail()
        }
        
        let expectedUserLogged = sut?.isUserLogged
        expect(expectedUserLogged).to(beTrue())
    }
    
    func testClearAll() {
        sut?.clearAll()
        
        let expectedID = sut?.userID
        let expectedUserName = sut?.userName
        let expectedToken = sut?.userToken
        let expectedUser = sut?.getUser()
        
        expect(expectedID).to(beNil())
        expect(expectedUserName).to(beNil())
        expect(expectedToken).to(beNil())
        expect(expectedUser).to(beNil())
    }
    
}
