//
//  PostsLocal.swift
//  PostsApp
//
//  Created by Moustafa on 22/02/2025.
//

import OSLog
import CoreData

protocol PostsLocalProtocol {
    func fetchPosts() async -> [PostModel]
    func save(item: PostModel) async -> Bool
    func clearData() async -> Bool
}

struct PostsLocal: PostsLocalProtocol {
    
    private let persistenceController: PersistenceController

    public init(
        persistenceController: PersistenceController = .shared
    ) {
        self.persistenceController = persistenceController
    }
    
    // MARK: - Core Data Operations

    func fetchPosts() async -> [PostModel] {
        let context = persistenceController.container.newBackgroundContext()
        
        var posts: [PostModel] = []
        let fetchRequest = PostEntity.fetchRequest()
        
        context.performAndWait {
            do {
                posts = try context
                    .fetch(fetchRequest)
                    .compactMap { $0.toDTO() }
            } catch {
                Logger().error("Failed to fetch posts: \(error.localizedDescription)")
            }
        }
        
        return posts
    }

    func save(item: PostModel) async -> Bool {
        
        let context = persistenceController.container.newBackgroundContext()
        var isSaved: Bool = false
        
        context.performAndWait {
            
            let entity = PostEntity(context: context)
            entity.id = Int16(item.id)
            entity.title = item.title
            entity.postDescription = item.description
            entity.like = item.isLiked
            
            do {
                try context.save()
                Logger().info("item saved")
                isSaved = true
            } catch {
                Logger().error("Error save Core Data: \(error.localizedDescription)")
                isSaved = false
                
            }
        }
        
        return isSaved
    }
    
    func clearData() async -> Bool {
        
        let context = persistenceController.container.newBackgroundContext()
        var isDeleted: Bool = false
        
        context.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
                Logger().info("All items deleted successfully")
                isDeleted = true
            } catch {
                Logger().error("Error deleting all items: \(error.localizedDescription)")
                isDeleted = false
            }
        }
        
        return isDeleted
    }
}
