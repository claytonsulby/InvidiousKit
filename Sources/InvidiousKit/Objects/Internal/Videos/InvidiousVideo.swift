//
//  InvidiousVideo.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousVideo: Codable {

    let type: String
    let title: String
    let videoId: String
    let videoThumbnails: [InvidiousVideoThumbnail]
    let error: String?
    
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
