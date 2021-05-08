//
//  Video.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct Video: Identifiable {
    
    internal init(from video: InvidiousVideo) {
        
        self.title = video.title
        self.id = video.videoId
        self.thumbnails = Self.getThumbnails(thumbnailsArray: video.videoThumbnails)
        
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
        
        self.formattedStreams = FormattedStream.fromStreamArray(streamArray: video.formatStreams)
        self.audioStreams = Self.getAudioStreams(streamArray: video.adaptiveFormats)
        self.videoStreams = Self.getVideoStreams(streamArray: video.adaptiveFormats)
        
        self.captions = Self.getCaptions(captionsArray: video.captions)
        
        self.recommendedVideos = Self.getRecommendedVideos(videos: video.recommendedVideos)
    }
    
    internal static func getThumbnails(thumbnailsArray: [InvidiousVideoThumbnail]) -> [Thumbnail] {
        var thumbnails = [Thumbnail]()
        for entry in thumbnailsArray {
            thumbnails.append(Thumbnail(quality: entry.quality, url: entry.url, width: entry.width, height: entry.height))
        }
        return thumbnails
    }
    
    private static func getVideoStreams(streamArray streams: [InvidiousAdaptiveFormat]) -> [VideoStream] {
        var videoStreams = [VideoStream]()
        for stream in streams {
            if stream.type.starts(with: "video") {
                videoStreams.append(VideoStream(from: stream)!)
            }
        }
        return videoStreams
    }
    
    private static func getAudioStreams(streamArray streams: [InvidiousAdaptiveFormat]) -> [AudioStream] {
        var audioStreams = [AudioStream]()
        for stream in streams {
            if stream.type.starts(with: "audio") {
                audioStreams.append(AudioStream(from: stream)!)
            }
        }
        return audioStreams
    }
    
    private static func getCaptions(captionsArray: [InvidiousCaption]) -> [Caption] {
        var captions = [Caption]()
        for caption in captionsArray {
            captions.append(Caption(from: caption))
        }
        return captions
    }
    
    private static func getRecommendedVideos(videos: [InvidiousVideoPreview]) -> [VideoPreview.RecommendedVideo] {
        var recommendedVideos = [VideoPreview.RecommendedVideo]()
        for video in videos {
            recommendedVideos.append(VideoPreview.RecommendedVideo(from: video))
        }
        return recommendedVideos
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
    
}
