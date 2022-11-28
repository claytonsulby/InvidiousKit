//
//  ChannelPreview.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Object responsible for storing data about a channel previews
public struct ChannelPreview {
    
    /// Object that stores data of a related channel preview
    public struct Related: ChannelData {
        
        /// Initializes RecommendedVideo from JSON decoded response
        /// - Parameter related: JSON decoded response from Invidious
        internal init(from related: InvidiousChannel.RelatedChannel) {
            self.name = related.author
            self.id = related.authorId
            self.url = URL(string: related.authorUrl)
            self.thumbnails = related.authorThumbnails.map { Channel.Icon(from: $0) }
        }
        
        public let name: String
        public let id: String
        public let url: URL?
        public let thumbnails: [Channel.Icon]
        
        public var subCount: Int32 = 0
        public var description: String = ""
    }
    
    /// Object that stores data of a channel preview that is returned from search.
    public struct SearchResult: Searchable, ChannelData, Identifiable {
        public var title: String { self.name }
        public var thumbnailUrl: URL? { self.thumbnails.first?.url }
        
        public var type: SearchOptions.AcceptableResultType { SearchOptions.AcceptableResultType.channel }
        public var author: String { self.name }
        public var authorId: String { self.id }
        public var authorUrl: URL? { self.url }
        
        /// Initializes RecommendedVideo from JSON decoded response
        /// - Parameter result: JSON decoded response from Invidious
        internal init(from result: InvidiousChannel.SearchResult) {
            self.name = result.author
            self.id = result.authorId
            self.url = URL(string: result.authorUrl)
            self.thumbnails = result.authorThumbnails.map { Channel.Icon(from: $0) }
            
            self.subCount = result.subCount
            self.videoCount = result.videoCount
            self.description = result.description
            self.descriptionHtml = result.descriptionHtml
        }
        
        
        public let name: String
        public let id: String
        public let url: URL?
        public let thumbnails: [Channel.Icon]
        
        public let subCount: Int32
        public let videoCount: Int64
        public let description: String
        public let descriptionHtml: String
    }
}

public protocol ChannelData {
    var name: String { get }
    var id: String { get }
    var url: URL? { get }
    var thumbnails: [Channel.Icon] { get }
    var subCount: Int32 { get }
    var description: String { get }
}
