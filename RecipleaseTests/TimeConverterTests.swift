import XCTest
@testable import Reciplease

class TimeConverterTests: XCTestCase {

    func testGiven15MinutesWhenConvertToStringThenGetCorrectResult() throws {
       let timeConverter = TimeConverter()
        
        let value = 15
        
        let result = timeConverter.formatTotaltime(value)
        
        XCTAssertEqual(result, "15m")
        
    }
    
    func testGiven60MinutesWhenConvertToStringThenGetCorrectResult() throws {
       let timeConverter = TimeConverter()
        
        let value = 60
        
        let result = timeConverter.formatTotaltime(value)
        
        XCTAssertEqual(result, "1h")
        
    }
    
    func testGiven120MinutesWhenConvertToStringThenGetCorrectResult() throws {
       let timeConverter = TimeConverter()
        
        let value = 120
        
        let result = timeConverter.formatTotaltime(value)
        
        XCTAssertEqual(result, "2h")
        
    }
    
    func testGiven90MinutesWhenConvertToStringThenGetCorrectResult() throws {
       let timeConverter = TimeConverter()
        
        let value = 90
        
        let result = timeConverter.formatTotaltime(value)
        
        XCTAssertEqual(result, "1h 30m")
        
    }
    
    func testGiven0MinutesWhenConvertToStringThenGetCorrectResult() throws {
       let timeConverter = TimeConverter()
        
        let value = 0
        
        let result = timeConverter.formatTotaltime(value)
        
        XCTAssertEqual(result, "--")
        
    }
    
    func testGivenNegativeMinutesWhenConvertToStringThenGetCorrectResult() throws {
       let timeConverter = TimeConverter()
        
        let value = -10
        
        let result = timeConverter.formatTotaltime(value)
        
        XCTAssertEqual(result, "--")
        
    }
    
    func testGiven3601MinutesWhenConvertToStringThenGetCorrectResult() throws {
       let timeConverter = TimeConverter()
        
        let value = 1441
        
        let result = timeConverter.formatTotaltime(value)
        
        XCTAssertEqual(result, "--")
        
    }
    
    
    func testGiven1MinutesWhenConvertToStringThenGetCorrectResult() throws {
        
        let formatterMock = DateComponentsFormatterMock()
        let timeConverter = TimeConverter(formatter: formatterMock)
        let value = 60
        
        let result = timeConverter.formatTotaltime(value)
        
        XCTAssertEqual(result, "--")
        
    }

}
