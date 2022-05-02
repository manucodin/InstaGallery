import XCTest
import Nimble
@testable import InstaGallery

final class UserDefaultsTests: XCTestCase {
    
    var sut: UserDefaultsInterface!
    
    override func setUp() {
        super.setUp()
        
        sut = UserDefaultsImp()
    }
    
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testSaveValueWithKey() {
        let testValue = "testValue"
        let testValueKey = "testValueKey"
        
        sut.save(value: testValue, withKey: testValueKey)
        
        let expectedValue = sut.getValue(withKey: testValueKey)
        
        expect(expectedValue).notTo(beNil())
        expect(expectedValue).to(be(testValue))
    }
    
    func testSaveDataWithKey() {
        let testDataObject = Data()
        let testDataObjectKey = "testValueKey"
        
        sut.save(value: testDataObject, withKey: testDataObjectKey)
        
        let expectedValue = sut.getData(withKey: testDataObjectKey)
        expect(expectedValue).notTo(beNil())
    }
    
    func testRemoveValueWithKey() {
        let testValue = "testValue"
        let testValueKey = "testValueKey"
        
        sut.save(value: testValue, withKey: testValueKey)
        sut.removeValue(withKey: testValueKey)
        
        let expectedValue = sut.getValue(withKey: testValueKey)
        expect(expectedValue).to(beNil())
        
    }
}

