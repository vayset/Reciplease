//
//  CoreDataContextProviderMock.swift
//  RecipleaseTests
//
//  Created by Saddam Satouyev on 01/06/2021.
//

@testable import Reciplease
import CoreData

enum MockError: Error {
    case unknownError
}

class CoreDataContextProviderMock: CoreDataContextProviderProtocol {
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save() {
        
    }
    
    func delete(recipeEntity: RecipeEntity) {
        
    }
    
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult {
        throw MockError.unknownError
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        })
        return container
    }()
    
}
