//
//  VideoAuthor.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Object responsible for storing data about a video author
public struct VideoAuthor: Identifiable {
    
    /// Default initializer
    /// - Parameters:
    ///   - name: Name of the video author
    ///   - id: Video author's id
    ///   - url: Video author's url
    ///   - icons: Array of  Video author's profile icons
    internal init(name: String, id: String, url: String, icons: [InvidiousAuthorThumbnail]) {
        self.name = name
        self.id = id
        self.url = url
        self.icons = icons.map { Channel.Icon(from: $0) }
    }
    
    public let name: String
    public let id: String
    public let url: String
    public let icons: [Channel.Icon]
    
}
