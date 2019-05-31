import XCTest
@testable import Tubi

class TubiTests: XCTestCase {
    
    var json: NSDictionary = ["title": "Joe",
                "image": "http://images.adrise.tv/JkC_Cw7UD2jcJtmg7dAAArPGXiE=/214x306/smart/img.adrise.tv/d57031bb-61c9-499e-bb7a-4461e76db235.jpg",
                "id": "369854",
                "index": 1]

    var movie: Movie?
    override func setUp() {
        movie = Movie(json: json)
    }

    override func tearDown() {
        movie = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Testing Extensions
    func testStringWhiteSpaceExtension() {
        let whiteSpace =  "    "
        XCTAssertTrue(whiteSpace.isEmptyOrWhiteSpace)
    }
    
    func testMovieIndex() {
        XCTAssertEqual(movie?.indexLabel, "Index: 1")
    }

    func testMovieTitle() {
        XCTAssertEqual(movie?.titleLabel, "Title: Joe")
    }
    
}
