//
//  MockPostsLocal+MockData.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

@testable import PostsApp

extension MockPostsLocal {
    
    func posts() -> [PostModel] {
        
        return[
            PostModel(
                id: 1,
                title: "post title",
                description: "post body",
                like: false
            ),
            PostModel(
                id: 2,
                title: "post title",
                description: "post body",
                like: false
            )
        ]
    }
}
