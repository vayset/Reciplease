import CoreData


class RecipeCoreDataManager {
    
    static let shared = RecipeCoreDataManager()
    
    
    
    // MARK: - INTERNAL
    
    func createRecipe(recipeDataContainer: RecipeDataContainer) {
        let recipeEntity = RecipeEntity(context: viewContext)
        recipeEntity.label = recipeDataContainer.recipe.label
        recipeEntity.imageData = recipeDataContainer.photo
    
        do {
            try viewContext.save()
        } catch {
            print("error")
        }
    }
    
    func deleteRecipe(with title: String) {
        let recipeEntities = getStoredRecipeEntities()
        
        for recipeEntity in recipeEntities where recipeEntity.label == title {
            viewContext.delete(recipeEntity)
        }
        
        saveContext()
        
    }
    
    func readRecipes() -> [RecipeDataContainer] {
        return getStoredRecipeEntities().map {
            
            let recipe = Recipe(uri: nil, label: $0.label, image: nil, source: nil, url: nil, shareAs: nil, yield: nil, dietLabels: nil, ingredientLines: nil, calories: nil, totalWeight: nil, totalTime: nil)
            let photoData = $0.imageData
            
            return RecipeDataContainer(recipe: recipe, photo: photoData)
        }
    }
    
    func updateText() {
        print("Is not implemented")
    }
    

    
    
    
    
    
    
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    // MARK: - Other
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    
    private func getStoredRecipeEntities() -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipeEntities = try? viewContext.fetch(request) else {
            return []
        }
        
        
        return recipeEntities
    }
    
    

  
}
