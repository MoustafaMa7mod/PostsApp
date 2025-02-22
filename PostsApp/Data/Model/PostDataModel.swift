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
