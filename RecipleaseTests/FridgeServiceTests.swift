import XCTest
@testable import Reciplease

class FridgeServiceTests: XCTestCase {

    func testAddIngredientFailIstoobig() throws {
       let fridgeService = FridgeService()
        
        let result = fridgeService.addIngredient("tomato")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .failedToAddIngredientIsTooBig)
        case .success:
            XCTFail()
            
        }
    }
}
