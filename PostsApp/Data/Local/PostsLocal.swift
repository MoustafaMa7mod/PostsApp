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
    func save(item: PostModel) async
    func clearData() async
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

    func save(item: PostModel) async {
        
        let context = persistenceController.container.newBackgroundContext()
        
        context.performAndWait {
            
            let entity = PostEntity(context: context)
            entity.id = Int16(item.id)
            entity.title = item.title
            entity.postDescription = item.description
            entity.like = item.isLiked
            
            do {
                try context.save()
            } catch {
                Logger().error("Error save Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    func clearData() async {
        
        let context = persistenceController.container.newBackgroundContext()
        
        context.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                Logger().error("Error deleting all items: \(error.localizedDescription)")
            }
        }
    }
}
