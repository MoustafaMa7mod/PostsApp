//
//  PostDataModel.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

struct PostDataModel: Codable {
    
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    init(
        userId: Int? = nil,
        id: Int? = nil,
        title: String? = nil,
        body: String? = nil
    ) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    func toEntity() -> PostModel {
        PostModel(
            id: id ?? 0,
            title: title ?? "",
            description: body ?? "",
            like: false
        )
    }
}

/// Maps the object from `WeatherInfoEntity` to `WeatherItem` .
extension PostEntity {
    
    func toDTO() -> PostModel {
        PostModel(
            id: Int(id),
            title: title ?? "",
            description: postDescription ?? "",
            like: like
        )
    }
}
