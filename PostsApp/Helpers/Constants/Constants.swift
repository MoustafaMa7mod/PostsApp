//
//  Constants.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import Foundation

/// A struct that defines constant values used throughout the application.
public struct Constants {

    /// A nested struct containing keys for retrieving values from the Info.plist file.
    public struct PlistKeys {
        /// The key used to retrieve the base URL from the Info.plist file.
        static let baseURL = "baseURL"
    }
}

extension Constants {
    
    /// A nested struct containing path url to send into network layer
    public struct Paths {
        /// The path used to append into base url to get data
        static let posts = "posts"
    }
}
