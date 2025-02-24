//
//  MockPostsLocal.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

@testable import PostsApp

class MockPostsLocal: PostsLocalProtocol {
    
    var storedPosts: [PostModel] = []
    var fetchPostsCalled = false
    var saveCalled = false
    var updateCalled = false
    var clearDataCalled = false

    func fetchPosts() async -> [PostModel] {
        fetchPostsCalled = true
        return storedPosts
    }

    func save(item: PostModel) async {
        saveCalled = true
        storedPosts.append(item)
    }

    func clearData() async {
        clearDataCalled = true
        storedPosts.removeAll()
    }
    
    func updatePost(item: PostsApp.PostModel) async -> Bool {
        updateCalled = true
        
        if let index = storedPosts.firstIndex(where: { $0.id == item.id }) {
            storedPosts[index] = item
            return updateCalled
        }
        
        return false
    }
}
