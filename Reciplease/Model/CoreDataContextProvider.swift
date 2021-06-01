//
//  CoreDataContextProvider.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 01/06/2021.
//

import Foundation
import CoreData

protocol CoreDataContextProviderProtocol {
    var viewContext: NSManagedObjectContext { get }
    
    func save()
    func delete(recipeEntity: RecipeEntity)
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult
    
}

class CoreDataContextProvider: CoreDataContextProviderProtocol {
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch { fatalError("Unresolved error") }
        }
    }
    
    func delete(recipeEntity: RecipeEntity) {
        viewContext.delete(recipeEntity)
    }
    
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult {
        try viewContext.fetch(request)
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        })
        return container
    }()
    
}
