//
//  ConfigurationManager.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import Foundation

/// A singleton class responsible for managing application configuration values.
/// This class retrieves values such as the API base URL from the app's Info.plist file.
class ConfigurationManager {

    /// The shared singleton instance of `ConfigurationManager`.
    static let shared = ConfigurationManager()

    /// Private initializer to prevent external instantiation.
    /// Ensures that only a single instance of `ConfigurationManager` exists.
    private init() { }

    /// Retrieves the base URL for network requests from the Info.plist file.
    /// - Returns: A `String` containing the base URL.
    var baseURL: String {
        Bundle.main.getValueFromInfoPlist(forKey: Constants.PlistKeys.baseURL)!
    }
}
