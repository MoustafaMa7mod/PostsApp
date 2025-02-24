//
//  MockPostsRemoteAPI+MockData.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

@testable import PostsApp

extension MockPostsRemoteAPI {
    
    func posts() -> [PostDataModel] {
        
        return[
            PostDataModel(
                userId: 1,
                id: 1,
                title: "post title",
                body: "post body"
            ),
            PostDataModel(
                userId: 2,
                id: 2,
                title: "post title",
                body: "post body"
            )
        ]
    }
}
