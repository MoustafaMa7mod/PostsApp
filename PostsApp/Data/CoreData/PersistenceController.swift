//
//  PersistenceController.swift
//  PostsApp
//
//  Created by Moustafa on 22/02/2025.
//
import CoreData
import OSLog

public class PersistenceController {

    // MARK: - Properties
    
    /// A shared singleton instance of `PersistenceController`, allowing centralized access
    /// to Core Data operations across the application.
    public static let shared = PersistenceController()

    /// The Core Data persistent container responsible for loading and managing the data model.
    let container: NSPersistentContainer
    
    // MARK: - Initialization

    /// Initializes the Core Data stack with an optional in-memory store for testing purposes.
    ///
    /// - Parameter inMemory: A Boolean flag indicating whether to use an in-memory store.
    ///   Defaults to `false`, meaning data is persisted normally.
    public init(inMemory: Bool = false) {
        
        // Load the Core Data model from the module bundle.
        guard let modelURL = Bundle.main.url(
            forResource: Constants.CoreData.modelName,
            withExtension: "momd"
        ), let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to locate Core Data model.")
        }

        // Initialize the persistent container with the loaded model.
        container = NSPersistentContainer(
            name: Constants.CoreData.modelName,
            managedObjectModel: managedObjectModel
        )

        // If in-memory storage is requested, use a temporary location.
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        // Load persistent stores and handle potential errors.
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
