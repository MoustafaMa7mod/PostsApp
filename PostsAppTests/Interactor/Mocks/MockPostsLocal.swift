//
//  MockPostsLocal.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

@testable import PostsApp

class MockPostsLocal: PostsLocalProtocol {
    
    var storedPosts: [PostModel] = []
    var isFetchPosts = false
    var isSave = false
    var isUpdate = false
    var isClearData = false

    func fetchPosts() async -> [PostModel] {
        isFetchPosts = true
        return storedPosts
    }

    func save(item: PostModel) async {
        isSave = true
        storedPosts.append(item)
    }

    func clearData() async {
        isClearData = true
        storedPosts.removeAll()
    }
    
    func updatePost(item: PostsApp.PostModel) async -> Bool {
        isUpdate = true
        
        if let index = storedPosts.firstIndex(where: { $0.id == item.id }) {
            storedPosts[index] = item
            return isUpdate
        }
        
        return false
    }
}
