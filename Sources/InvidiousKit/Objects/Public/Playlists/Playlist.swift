//
//  Playlist.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Object responsible for storing playlist data
public struct Playlist: Identifiable, PlaylistData {
    ///Object that stores the playlist preview which is returned from search
    public typealias SearchResult = ChannelPlaylist
    
    /// Initializes Playlist from JSON decoded response
    /// - Parameter playlist: JSON decoded response from Invidious
    internal init(from playlist: InvidiousPlaylist) {
        self.title = playlist.title
        self.id = playlist.playlistId
        
        self.thumbnailUrl = playlist.playlistThumbnail
        
        self.author = playlist.author
        self.authorId = playlist.authorId
        self.authorThumbnails = playlist.authorThumbnails.map { Channel.Icon(from: $0) }
        
        self.description = playlist.description
        self.descriptionHtml = playlist.descriptionHtml
        
        self.videoCount = playlist.videoCount
        self.viewCount = playlist.viewCount
        self.lastUpdated = Date(timeIntervalSince1970: Double(playlist.updated))
        
        self.videos = playlist.videos.map { VideoPreview.PlaylistEntry(from: $0) }
    }
    
    public let title: String
    public let id: String

    public let thumbnailUrl: String
    
    public let author: String
    public let authorId: String
    public let authorThumbnails: [Channel.Icon]
    
    public let description: String
    public let descriptionHtml: String
    
    public let videoCount: Int32
    public let viewCount: Int64
    public let lastUpdated: Date
    
    public let videos: [VideoPreview.PlaylistEntry]
}

/// Object responsible for storing playlist data
public struct ChannelPlaylist: Searchable, PlaylistData, Identifiable {
    
    /// Initializes Playlist from JSON decoded response
    /// - Parameter playlist: JSON decoded response from Invidious
    internal init(from playlist: InvidiousChannelPlaylist) {
        self.title = playlist.title
        self.id = playlist.playlistId
        
        self.thumbnailUrl = playlist.playlistThumbnail
        
        self.author = playlist.author
        self.authorId = playlist.authorId
        self.authorUrl = playlist.authorUrl
        
        self.videoCount = playlist.videoCount
        self.videos = playlist.videos.map { VideoPreview.ChannelPlaylistEntry(from: $0) }
    }
    
    public let title: String
    public let id: String

    public let thumbnailUrl: String
    
    public let author: String
    public let authorId: String
    public let authorUrl: String
    
    public let videoCount: Int32
    public let videos: [VideoPreview.ChannelPlaylistEntry]
    
}

protocol PlaylistData {
    var title: String { get }
    var id: String { get }
    var author: String { get }
    var authorId: String { get }
    var videoCount: Int32 { get }
}
