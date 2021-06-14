//
//  VideoPreview.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Object responsible for storing data about a video previews
public struct VideoPreview {
    
    ///Object that stores the Video preview that is returned from a search
    public typealias SearchResult = ChannelVideo
    
    /// Object that stores data of a recommended video preview
    public struct RecommendedVideo: VideoData, Identifiable {
        
        /// Initializes RecommendedVideo from JSON decoded response
        /// - Parameter video: JSON decoded response from Invidious
        internal init(from video: InvidiousVideoPreview) {
            self.id = video.videoId
            self.title = video.title
            self.thumbnails = video.videoThumbnails.map { Thumbnail(from: $0) }
            self.author = video.author
            self.authorId = video.authorId
            self.lengthSeconds = video.lengthSeconds
            self.viewCount = video.viewCount
            self.viewCountText = video.viewCountText
        }
        
        public let id: String
        public let title: String
        public let thumbnails: [Thumbnail]
        public let author: String
        public let authorId: String
        public let lengthSeconds: Int32
        public let viewCount: Int64
        public let viewCountText: String
    }
    
    /// Object that store data of a popular video preview
    public struct PopularVideo: VideoData, Identifiable {
        
        /// Initializes PopularVideo from JSON decoded response
        /// - Parameter video: JSON decoded response from Invidious
        internal init(from video: InvidiousVideoPreview.PopularVideo) {
            self.title = video.title
            self.id = video.videoId
            self.thumbnails = video.videoThumbnails.map { Thumbnail(from: $0) }
            
            self.lengthSeconds = video.lengthSeconds
            self.viewCount = video.viewCount
            
            self.author = video.author
            self.authorId = video.authorId
            self.authorUrl = video.authorUrl
            
            self.published = video.published
            self.publishedText = video.publishedText
        }
        
        public let title: String
        public let id: String
        public let thumbnails: [Thumbnail]
        
        public let lengthSeconds: Int32
        public let viewCount: Int64
        
        public let author: String
        public let authorId: String
        public let authorUrl: String
        
        public let published: Int64
        public let publishedText: String
        
    }
    
    /// Object that stores data of a channel video preview, can be returned from search.
    public struct ChannelVideo: Searchable, VideoData, Identifiable {
        
        /// Initializes ChannelVideo from JSON decoded response
        /// - Parameter video: JSON decoded response from Invidious
        internal init(from video: InvidiousVideoPreview.ChannelVideo) {
            self.type = video.type
            self.title = video.title
            self.id = video.videoId
            self.thumbnails = video.videoThumbnails.map { Thumbnail(from: $0) }
            
            self.lengthSeconds = video.lengthSeconds
            self.viewCount = video.viewCount
            self.author = video.author
            self.authorId = video.authorId
            self.authorUrl = video.authorUrl
            
            self.published = video.published
            self.publishedText = video.publishedText
            self.description = video.description
            self.descriptionHtml = video.descriptionHtml
            
            self.liveNow = video.liveNow
            self.paid = video.paid
            self.premium = video.premium
        }
        
        public let type: String
        public let title: String
        public let id: String
        public let thumbnails: [Thumbnail]
        
        public let lengthSeconds: Int32
        public let viewCount: Int64
        
        public let author: String
        public let authorId: String
        public let authorUrl: String
        
        public let published: Int64
        public let publishedText: String
        public let description: String
        public let descriptionHtml: String
        
        public let liveNow: Bool
        public let paid: Bool
        public let premium: Bool
        
    }
    
    /// Object that stores data of a video playlist entry
    public struct PlaylistEntry: VideoData {
        
        /// Initializes PlaylistEntry from JSON decoded reponse
        /// - Parameter entry: JSON decoded response from Invidious
        init(from entry: InvidiousVideoPreview.PlaylistEntry) {
            self.title = entry.title
            self.id = entry.title
            self.author = entry.author
            self.authorId = entry.authorId
            self.authorUrl = entry.authorUrl
            
            self.index = entry.index
            self.lengthSeconds = entry.lengthSeconds
            
            self.thumbnails = entry.videoThumbnails.map { Thumbnail(from: $0) }
        }
        
        let title: String
        let id: String
        let author: String
        let authorId: String
        let authorUrl: String
        
        let index: Int32
        let lengthSeconds: Int32
        
        let thumbnails: [Thumbnail]
        
    }
    
    /// Object that stores data of a channel video playlist entry
    public struct ChannelPlaylistEntry: Identifiable {
        
        /// Initializes ChannelPlaylistEntry from JSON decoded reponse
        /// - Parameter entry: JSON decoded response from Invidious
        internal init(from entry: InvidiousVideoPreview.ChannelPlaylistEntry) {
            self.title = entry.title
            self.id = entry.videoId
            self.lengthSeconds = entry.lengthSeconds
            self.thumbnails = entry.videoThumbnails.map { Thumbnail(from: $0) }
        }
        
        public let title: String
        public let id: String
        public let lengthSeconds: Int32
        public let thumbnails: [Thumbnail]
        
    }
}

public protocol VideoData {
    public let title: String
    public let thumbnails: [Thumbnail]
    public let author: String
    public let authorId: String
    public let lengthSeconds: Int32
}
