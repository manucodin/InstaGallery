//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 1/5/22.
//

import XCTest
import Nimble
@testable import InstaGallery

final class UserMapperTests: XCTestCase {
    
    var sut: IGUserMapper!

    override func setUp() {
        super.setUp()
        
        sut = IGUserMapper()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testMappingDTOToDomain() {
        let userDTO = IGUserDTOMother.user()
        
        let expectedUser = sut.transform(dto: userDTO)
        expect(expectedUser.identifier).to(equal(userDTO.id))
        expect(expectedUser.account).to(equal(userDTO.username))
        expect(expectedUser.urlAccount).to(equal(userDTO.urlAccount))
        expect(expectedUser.token).to(equal(userDTO.token))
    }
    
    func testMappingDomainToDTO() {
        let user = IGUserMother.user()
        
        let expectedUser = sut.transform(model: user)
        expect(expectedUser.id).to(equal(user.identifier))
        expect(expectedUser.username).to(equal(user.account))
        expect(expectedUser.urlAccount).to(equal(user.urlAccount))
        expect(expectedUser.token).to(equal(user.token))
    }
}
