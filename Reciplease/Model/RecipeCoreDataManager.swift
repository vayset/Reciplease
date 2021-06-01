import Foundation
import CoreData

class RecipeCoreDataManager {
    
    // MARK: - Internal

    // MARK: - Properties - Private
    
    static let shared = RecipeCoreDataManager()
        
    // MARK: - Methods - Internal
    
    init(coreDataContextProvider: CoreDataContextProviderProtocol = CoreDataContextProvider()) {
        self.coreDataContextProvider = coreDataContextProvider
    }

    func createRecipe(recipeDataContainer: RecipeDataContainer) {
        let recipeEntity = RecipeEntity(context: coreDataContextProvider.viewContext)
        recipeEntity.label = recipeDataContainer.recipe.label
        recipeEntity.imageData = recipeDataContainer.photo
        recipeEntity.ingredientLines = recipeDataContainer.recipe.ingredientLines as NSObject?
        recipeEntity.recipeUrl = recipeDataContainer.recipe.url
        if let totalTime = recipeDataContainer.recipe.totalTime {
            recipeEntity.totalTime = Int32(totalTime)
        }
        
        coreDataContextProvider.save()
    }
    
    func deleteRecipe(with title: String) {
        let recipeEntities = getStoredRecipeEntities()
        
        for recipeEntity in recipeEntities where recipeEntity.label == title {
            coreDataContextProvider.delete(recipeEntity: recipeEntity)
        }
        coreDataContextProvider.save()
    }
    
    func deleteAllRecipes() {
        let recipeEntities = getStoredRecipeEntities()
        
        for recipeEntity in recipeEntities {
            coreDataContextProvider.delete(recipeEntity: recipeEntity)
        }
        coreDataContextProvider.save()
    }
    
    func readRecipes() -> [RecipeDataContainer] {
        return getStoredRecipeEntities().map {
            
            let recipe = Recipe(
                uri: nil,
                label: $0.label,
                image: nil,
                source: nil,
                url: $0.recipeUrl,
                shareAs: nil,
                yield: nil,
                dietLabels: nil,
                ingredientLines: $0.ingredientLines as? [String],
                calories: nil,
                totalWeight: nil,
                totalTime: Int($0.totalTime)
            )
            let photoData = $0.imageData
            
            return RecipeDataContainer(recipe: recipe, photo: photoData)
        }
    }
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let coreDataContextProvider: CoreDataContextProviderProtocol
    
    // MARK: - Methods - Private

    private func getStoredRecipeEntities() -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipeEntities = try? coreDataContextProvider.fetch(request) else {
            return []
        }
        return recipeEntities
    }
}
