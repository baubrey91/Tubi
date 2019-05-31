import XCTest
@testable import Tubi

class CacheTests: XCTestCase {
    
    //Subject under test
    var cache: TubiCache<Int, String>?
    
    override func setUp() {
        //Arrange
        cache = TubiCache<Int, String>(capacity: 4)
    }
    
    override func tearDown() {
        cache = nil
    }
    
    func testCacheCapacity() {
        //Assert
        XCTAssertEqual(cache?.capacity, 4)
    }
    
    func testCacheInsert() {
        cache?.add(key: 1, value: "One")
        //Assert
        XCTAssertEqual(cache?.length, 1)
    }
    
    func testCacheInsertPastMax() {
        //Act
        cache?.add(key: 1, value: "One")
        cache?.add(key: 2, value: "Two")
        cache?.add(key: 3, value: "Three")
        cache?.add(key: 4, value: "Four")
        cache?.add(key: 5, value: "Five")
        //Assert
        XCTAssertEqual(cache?.length, 4)
    }
    
    func testCacheInsertValue() {
        //Act
        cache?.add(key: 1, value: "One")
        //Assert
        XCTAssertEqual(cache?.get(key: 1), "One")
    }
    
    func testCacheInsertPastMaxValue() {
        //Act
        cache?.add(key: 1, value: "One")
        cache?.add(key: 2, value: "Two")
        cache?.add(key: 3, value: "Three")
        cache?.add(key: 4, value: "Four")
        cache?.add(key: 5, value: "Five")
        //Assert
        XCTAssertFalse(cache!.isValid(key: 1))
    }
    
    func testCacheInsertPastMaxWithReuse() {
        //Act
        cache?.add(key: 1, value: "One")
        cache?.add(key: 2, value: "Two")
        cache?.add(key: 3, value: "Three")
        cache?.add(key: 4, value: "Four")
        cache?.get(key: 1)
        cache?.add(key: 5, value: "Five")
        cache?.add(key: 6, value: "Six")
        //One should be valid as it was re-used putting it to the top
        
        //Assert
        XCTAssertTrue(cache!.isValid(key: 1))
    }
}
