//
//  ChannelPreview.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct ChannelPreview {
    
    public struct Related {
        
        internal init(from related: InvidiousChannel.RelatedChannel) {
            self.name = related.author
            self.id = related.authorId
            self.url = related.authorUrl
            self.thumbnails = related.authorThumbnails.map { Channel.Icon(from: $0) }
        }
        
        public let name: String
        public let id: String
        public let url: String
        public let thumbnails: [Channel.Icon]
    }
    
    public struct SearchResult: Searchable, Identifiable {
        
        public var author: String { self.name }
        public var authorId: String { self.id }
        public var authorUrl: String { self.url }
        
        
        internal init(from result: InvidiousChannel.SearchResult) {
            self.name = result.author
            self.id = result.authorId
            self.url = result.authorUrl
            self.thumbnails = result.authorThumbnails.map { Channel.Icon(from: $0) }
            
            self.subCount = result.subCount
            self.videoCount = result.videoCount
            self.description = result.description
            self.descriptionHtml = result.descriptionHtml
        }
        
        
        public let name: String
        public let id: String
        public let url: String
        public let thumbnails: [Channel.Icon]
        
        public let subCount: Int32
        public let videoCount: Int64
        public let description: String
        public let descriptionHtml: String
    }
}
