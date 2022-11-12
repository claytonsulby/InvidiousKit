//
//  InvidiousVideo.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousVideo: Codable {

    let error: String?
    
    let type: String
    let title: String
    let videoId: String
    let videoThumbnails: [InvidiousVideoThumbnail]
    let storyboards: [InvidiousStoryboard]
    
    let description: String
    let descriptionHtml: String
    let published: Int64
    let publishedText: String
    
    let keywords: [String]
    let viewCount: Int64
    let likeCount: Int64
    let dislikeCount: Int64
    
    let paid: Bool
    let premium: Bool
    let isFamilyFriendly: Bool
    let allowedRegions: [String]
    let genre: String
    let genreUrl: String?
    
    let author: String
    let authorId: String
    let authorUrl: String
    let authorThumbnails: [InvidiousAuthorThumbnail]
    
    let subCountText: String
    let lengthSeconds: Int32
    let allowRatings: Bool
    let rating: Float32
    let isListed: Bool
    let liveNow: Bool
    let isUpcoming: Bool
    let premiereTimestamp: Int64?
    
    let dashUrl: String
    let adaptiveFormats: [InvidiousAdaptiveFormat]
    let formatStreams: [InvidiousStreamFormat]
    let captions: [InvidiousCaption]
    let recommendedVideos: [InvidiousVideoPreview]
}

// MARK: - Storyboard
struct InvidiousStoryboard: Codable {
    let url: String
    let templateUrl: String
    let width: Int32
    let height: Int32
    let count: Int64
    let interval: Int64
    let storyboardWidth: Int32
    let storyboardHeight: Int32
    let storyboardCount: Int64
}
