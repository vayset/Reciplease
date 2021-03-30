import CoreData


class RecipeCoreDataManager {
    
    static let shared = RecipeCoreDataManager()
    
    
    
    // MARK: - INTERNAL
    
    func createRecipe(recipe: Recipe) {
        let recipeEntity = RecipeEntity(context: viewContext)
        recipeEntity.label = recipe.label
        
        do {
            try viewContext.save()
        } catch {
            print("error")
        }
    }
    
    func readRecipes() -> [Recipe] {
        return getStoredRecipeEntities().map {
            Recipe(uri: nil, label: $0.label, image: nil, source: nil, url: nil, shareAs: nil, yield: nil, dietLabels: nil, ingredientLines: nil, calories: nil, totalWeight: nil, totalTime: nil)
            
        }
    }
    
    func updateText() {
        print("Is not implemented")
    }
    
    
    func deleteAllTexts() {
        let recipeEntities = getStoredRecipeEntities()
        
        for recipeEntity in recipeEntities {
            viewContext.delete(recipeEntity)
        }
        
        saveContext()
    }
    
    
    
    
    
    
    
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "Projet_dominer_le_monde")
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
