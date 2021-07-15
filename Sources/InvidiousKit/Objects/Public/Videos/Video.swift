//
//  Video.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Object responsible for storing video data
public struct Video: Identifiable {
    
    /// Initializes Video from JSON decoded response
    /// - Parameter video: JSON decoded response from Invidious
    internal init(from video: InvidiousVideo) {
        
        self.title = video.title
        self.id = video.videoId
        self.thumbnails = video.videoThumbnails.map { Thumbnail(from: $0)}
        
        self.description = video.description
        self.descriptionHtml = video.descriptionHtml
        
        self.published = Date(timeIntervalSince1970: Double(video.published))
        self.publishedText = video.publishedText
        
        self.keywords = video.keywords
        self.views = video.viewCount
        self.likes = video.likeCount
        self.dislikes = video.dislikeCount
        
        self.paid = video.paid
        self.premium = video.premium
        self.allowedRegions = video.allowedRegions
        self.genre = video.genre
        self.genreUrl = video.genreUrl
        
        self.author = VideoAuthor(name: video.author, id: video.authorId, url: video.authorUrl, icons: video.authorThumbnails)
        
        self.subCountText = video.subCountText
        self.length = video.lengthSeconds
        self.ratingsAllowed = video.allowRatings
        self.rating = video.rating
        self.listed = video.isListed
        self.upcoming = video.isUpcoming
        self.premiereTimestamp = Date(timeIntervalSince1970: Double(video.premiereTimestamp ?? -1))
        
        self.dashUrl = video.dashUrl
        
        self.formattedStreams = video.formatStreams.map { FormattedStream(from: $0) }
        
        self.audioStreams = video.adaptiveFormats.compactMap { stream -> AudioStream? in
            if stream.type.starts(with: "audio") {
                return AudioStream(from: stream)
            }
            return nil
        }
        self.videoStreams = video.adaptiveFormats.compactMap { stream -> VideoStream? in
            if stream.type.starts(with: "video") {
                return VideoStream(from: stream)
            }
            return nil
        }
        
        self.captions = video.captions.map { Caption(from: $0) }
        
        self.recommendedVideos = video.recommendedVideos.map { VideoPreview.RecommendedVideo(from: $0) }
    }
    
    public let title: String
    public let id: String
    public let thumbnails: [Thumbnail]
    
    public let description: String
    public let descriptionHtml: String
    
    public let published: Date
    public let publishedText: String
    
    public let keywords: [String]
    public let views: Int64
    public let likes: Int64
    public let dislikes: Int64
    
    public let paid: Bool
    public let premium: Bool
    public let allowedRegions: [String]
    public let genre: String
    public let genreUrl: String?
    
    public let author: VideoAuthor
    
    public let subCountText: String
    public let length: Int32
    public let ratingsAllowed: Bool
    public let rating: Float32
    public let listed: Bool
    public let upcoming: Bool
    public let premiereTimestamp: Date?
    
    public let dashUrl: String
    
    public let audioStreams: [AudioStream]
    public let videoStreams: [VideoStream]
    public let formattedStreams: [FormattedStream]
    public let captions: [Caption]
    
    public let recommendedVideos: [VideoPreview.RecommendedVideo]
    
    public func getVideoData() -> VideoData {
        return VideoPreview.PopularVideo(title: title, id: id, author: author.name, authorId: author.id, authorUrl: author.url, lenght: length, viewCount: views, published: (published.timeIntervalSince1970 as? Int64) ?? 0, publishedText: publishedText, thumbnails: thumbnails)
    }

}
