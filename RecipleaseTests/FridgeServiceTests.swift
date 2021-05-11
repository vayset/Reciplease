import XCTest
@testable import Reciplease

class FridgeServiceTests: XCTestCase {
    
    
    // MARK: Add Ingredient

    func testAddIngredientFailIngredientIsEmpty() throws {
       let fridgeService = FridgeService()
        
        let result = fridgeService.addIngredient(" ")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .failedToAddIngredientIsEmpty)
        case .success:
            XCTFail()
            
        }
    }
    
    func test_givenAlreadyAddedIngredient_whenAddSameIngredient_FailIngredientIsAlreadyAdded() throws {
       let fridgeService = FridgeService()
        
        _ = fridgeService.addIngredient("lemon")
        
        
        
        let result = fridgeService.addIngredient("lemon")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .failedToAddIngredientIsAlreadyAdded)
        case .success:
            XCTFail()
    
        }
    }
    
    
    func test_givenAlreadyAddedIngredient_whenAddSameIngredientWithEndWhiteSpace_FailIngredientIsAlreadyAdded() throws {
       let fridgeService = FridgeService()
        
        _ = fridgeService.addIngredient("lemon ")
        
        
        
        let result = fridgeService.addIngredient("lemon")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .failedToAddIngredientIsAlreadyAdded)
        case .success:
            XCTFail()
    
        }
    }
    
    
    func test_givenAlreadyAddedIngredient_whenAddSameIngredientWithStartWhiteSpace_FailIngredientIsAlreadyAdded() throws {
       let fridgeService = FridgeService()
        
        _ = fridgeService.addIngredient(" lemon")
        
        
        
        let result = fridgeService.addIngredient("lemon")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .failedToAddIngredientIsAlreadyAdded)
        case .success:
            XCTFail()
    
        }
    }
    
    
    
    func test_givenAlreadyAddedIngredient_whenAddSameIngredientWithStartAndEndWhiteSpace_FailIngredientIsAlreadyAdded() throws {
       let fridgeService = FridgeService()
        
        _ = fridgeService.addIngredient(" lemon      ")
        
        
        
        let result = fridgeService.addIngredient("lemon")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .failedToAddIngredientIsAlreadyAdded)
        case .success:
            XCTFail()
    
        }
    }
    
    
    func test_givenAlreadyAddedIngredientNotCapitalized_whenAddSameIngredientCapitalized_FailIngredientIsAlreadyAdded() throws {
       let fridgeService = FridgeService()
        
        _ = fridgeService.addIngredient("lemon")
        
        
        let result = fridgeService.addIngredient("Lemon")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .failedToAddIngredientIsAlreadyAdded)
        case .success:
            XCTFail()
    
        }
    }
    
    func test_givenAlreadyAddedIngredientWithSpecialCasing_whenAddSameIngredientWithDifferentCasing_thenFailIngredientIsAlreadyAdded() throws {
       let fridgeService = FridgeService()
        
        _ = fridgeService.addIngredient("lEmOn")
        
        
        let result = fridgeService.addIngredient("Lemon")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .failedToAddIngredientIsAlreadyAdded)
        case .success:
            XCTFail()
    
        }
    }
    
    func testAddIngredientSucces() throws {
       let fridgeService = FridgeService()
        
        let result = fridgeService.addIngredient("lemon")
        
        switch result {
        case .failure( _):
            XCTFail()
        case .success:
            XCTAssertTrue(true)
        }
    }
    
    func test_givenEmptyIngredientList_whenMultipleIngredientSeparatedByCommaAtOnce_thenAllIngredientsAreAddded() throws {
       let fridgeService = FridgeService()
        
        let result = fridgeService.addIngredient("lemon, orange, tomato")
        
        switch result {
        case .failure( _):
            XCTFail()
        case .success:
            XCTAssertEqual(fridgeService.ingredients, ["lemon", "orange", "tomato"])
        }
    }
    
    
    // MARK: Get Recipes
    
    func test_givenEmptyIngredients_whenGetRecipes_thenFailure() throws {
        let fridgeService = FridgeService()
        
        
        XCTAssertTrue(fridgeService.ingredients.isEmpty)
        
        fridgeService.getRecipes { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .failedToGetRecipesIngredientIsEmpty)
            case .success:
                XCTFail()
            }
        }
       
        
    }
    
    func test_givenNonEmptyIngredientsAndBadUrlComponent_whenGetRecipes_thenGetCouldNotCreateUrlFailure() throws {
        let urlComponentsMock = UrlComponentsMock()
        let fridgeService = FridgeService(urlComponents: urlComponentsMock)
        
        _ = fridgeService.addIngredient("yomsto")
        
        XCTAssertFalse(fridgeService.ingredients.isEmpty)
        
        fridgeService.getRecipes { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .couldNotCreateUrl)
            case .success:
                XCTFail()
            }
        }
       
        
    }
    
    func test_givenNonEmptyIngredientsAndBadNetworkManager_whenGetRecipes_thenGetBackendFailure() throws {

        let networkManagerMock = NetworkManagerFailureMock()
        let fridgeService = FridgeService(networkManager: networkManagerMock)
        
        _ = fridgeService.addIngredient("yomsto")
        
        
        fridgeService.getRecipes { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .failedToGetRecipesBackendError)
            case .success:
                XCTFail()
            }
        }
       
        
    }
    
    func test_givenNonEmptyIngredientsAndGoodNetworkManger_whenGetRecipes_thenGetRecipesSuccess() throws {

        let networkManagerMock = NetworkManagerSuccessMock()
        let fridgeService = FridgeService(networkManager: networkManagerMock)
        
        _ = fridgeService.addIngredient("yomsto")
        
        
        fridgeService.getRecipes { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let recipes):
                XCTAssertEqual(recipes.count, 1)
               
            }
        }
       
        
    }
    
    
}
