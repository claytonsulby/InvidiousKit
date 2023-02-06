//
//  Channel.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Object responsible for storing video data
public struct Channel: ChannelData, Identifiable, StringError {

//    /// Filter that dictates, how vidoes should be sorted
//    public enum SortDescriptor {
//        case newest
//        case oldest
//        case popular
//
//        func toString() -> String {
//            switch self {
//                case .newest:
//                    return "newest"
//                case .oldest:
//                    return "oldest"
//                case .popular:
//                    return "popular"
//            }
//        }
//    }
    
    /// Object responsible for storing channel icon data
    public struct Icon {
        
        internal init(from thumbnail: InvidiousAuthorThumbnail) {
            self.url = URL(string: thumbnail.url)
            self.width = thumbnail.width
            self.height = thumbnail.height
        }
        
        public let url: URL?
        public let width: Int32
        public let height: Int32
    }
    
    /// Object responsible for storing channel banned data
    public struct Banner {
        
        internal init(from thumbnail: InvidiousAuthorBanner) {
            self.url = URL(string: thumbnail.url)
            self.width = thumbnail.width
            self.height = thumbnail.height
        }
        
        public let url: URL?
        public let width: Int32
        public let height: Int32
    }
    
    /// Initializes Video from JSON decoded response
    /// - Parameter channel: JSON decoded response from Invidious
    internal init(from channel: InvidiousChannel) {
        self.name = channel.author
        self.id = channel.authorId
        self.url = URL(string: channel.authorUrl)
        self.banners = channel.authorBanners.map { Banner(from: $0) }
        self.thumbnails = channel.authorThumbnails.map { Icon(from: $0) }
        self.error = channel.error
        
        self.subCount = channel.subCount
        self.totalViews = channel.totalViews
        self.joined = channel.joined
        
        self.paid = channel.paid ?? false
        self.autoGenerated = channel.autoGenerated
        self.isFamilyFriendly = channel.isFamilyFriendly
        self.description = channel.description
        self.descriptionHtml = channel.descriptionHtml
        self.allowedRegions = channel.allowedRegions
        
        self.latestVideos = channel.latestVideos.map { VideoPreview.ChannelVideo(from: $0) }
        self.relatedChannels = channel.relatedChannels.map { ChannelPreview.Related(from: $0) }
    }
    
    public let name: String
    public let id: String
    public let url: URL?
    public let banners: [Banner]
    public let thumbnails: [Icon]
    public let error: String?
    
    public let subCount: Int32
    public let totalViews: Int64
    public let joined: Int64
    
    public let paid: Bool
    public let autoGenerated: Bool
    public let isFamilyFriendly: Bool
    public let description: String
    public let descriptionHtml: String
    public let allowedRegions: [String]
    
    public let latestVideos: [VideoPreview.ChannelVideo]
    public let relatedChannels: [ChannelPreview.Related]
}
