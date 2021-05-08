//
//  Playlist.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct Playlist: Identifiable {
    public typealias SearchResult = ChannelPlaylist
    
    internal init(from playlist: InvidiousPlaylist) {
        self.title = playlist.title
        self.id = playlist.playlistId
        
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

public struct ChannelPlaylist: Searchable, Identifiable {
    
    internal init(from playlist: InvidiousChannelPlaylist) {
        self.title = playlist.title
        self.id = playlist.playlistId
        
        self.author = playlist.author
        self.authorId = playlist.authorId
        self.authorUrl = playlist.authorUrl
        
        self.videoCount = playlist.videoCount
        self.videos = playlist.videos.map { VideoPreview.ChannelPlaylistEntry(from: $0) }
    }
    
    public let title: String
    public let id: String

    public let author: String
    public let authorId: String
    public let authorUrl: String
    
    public let videoCount: Int32
    public let videos: [VideoPreview.ChannelPlaylistEntry]
    
}

