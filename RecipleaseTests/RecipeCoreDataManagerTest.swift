//
//  RecipeCoreDataManagerTest.swift
//  RecipleaseTests
//
//  Created by Saddam Satouyev on 21/05/2021.
//

@testable import Reciplease
import XCTest

class RecipeCoreDataManagerTest: XCTestCase {
    
    var recipeCoreDataManager: RecipeCoreDataManager!
//    var coreDataStack: CoreDataStackMock!
    
//    func testAddRecipeMethods_WhenARecipeIsCreated_ThenshouldBeCorrectlySaved() {
//        recipeCoreDataManager.createRecipe(recipeDataContainer: .init(recipe: .init(uri: nil, label: nil, image: "www.google.com", source: nil, url: nil, shareAs: nil, yield: nil, dietLabels: nil, ingredientLines: nil, calories: nil, totalWeight: nil, totalTime: nil)))
//        XCTAssertFalse(recipeCoreDataManager.   .recipesFav.isEmpty)
//        XCTAssertTrue(coreDataManager.recipesFav.count == 1)
//    }
    
    
    
    override func setUp() {
        super.setUp()
        recipeCoreDataManager = RecipeCoreDataManager()
        recipeCoreDataManager.deleteAllRecipes()
    }
    
    
    func test_givenNoRecipeStoredInDatabase_whenCreateRecipe_thenReadOneStoredRecipe() {
        
        XCTAssertTrue(recipeCoreDataManager.readRecipes().isEmpty)
        
        createMockRecipeInDatabase(label: "Pizza")
        
        XCTAssertTrue(!recipeCoreDataManager.readRecipes().isEmpty)

    }
    
    
    func test_givenMultipleRecipesCreatedInDatabase_whenDeleteSpecificRecipe_thenIsAbsentWhenReading() {
        XCTAssertTrue(recipeCoreDataManager.readRecipes().isEmpty)
        createMockRecipeInDatabase(label: "Pizza")
        createMockRecipeInDatabase(label: "Pasta")
        createMockRecipeInDatabase(label: "Tiramisu")
        
        XCTAssertEqual(recipeCoreDataManager.readRecipes().count, 3)
        
        recipeCoreDataManager.deleteRecipe(with: "Pasta")
        
        XCTAssertEqual(recipeCoreDataManager.readRecipes().count, 2)
        let containsPasta = recipeCoreDataManager.readRecipes().contains { recipeContainer in
            recipeContainer.recipe.label == "Pasta"
        }
        
        XCTAssertFalse(containsPasta)
        
    }
    
    
    private func createMockRecipeInDatabase(label: String) {
        let recipe = Recipe(
            uri: nil,
            label: label,
            image: "www.google.com",
            source: nil,
            url: nil,
            shareAs: nil,
            yield: nil,
            dietLabels: nil,
            ingredientLines: nil,
            calories: nil,
            totalWeight: nil,
            totalTime: 50
        )
        
        let recipeContainer = RecipeDataContainer(recipe: recipe)
        recipeCoreDataManager.createRecipe(recipeDataContainer: recipeContainer)
    }
}
