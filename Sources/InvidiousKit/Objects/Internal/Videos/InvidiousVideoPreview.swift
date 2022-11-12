//
//  InvidiousVideoPreview.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousVideoPreview: Codable {
    
    let videoId: String
    let title: String
    let videoThumbnails: [InvidiousVideoThumbnail]
    let author: String
    let authorId: String
    let authorUrl: String
    let lengthSeconds: Int32
    let viewCountText: String
    let viewCount: Int64
    
    struct ChannelVideo: Codable {
        
        let type: String
        let title: String
        let videoId: String
        let videoThumbnails: [InvidiousVideoThumbnail]
        
        let lengthSeconds: Int32
        let viewCount: Int64
        
        let author: String
        let authorId: String
        let authorUrl: String
        
        let published: Int64
        let publishedText: String
        let description: String
        let descriptionHtml: String
        
        let liveNow: Bool
        let premium: Bool
        let isUpcoming: Bool
    }
    
    struct PopularVideo: Codable {
        
        let title: String
        let videoId: String
        let videoThumbnails: [InvidiousVideoThumbnail]
        
        let lengthSeconds: Int32
        let viewCount: Int64
        
        let author: String
        let authorId: String
        let authorUrl: String
        
        let published: Int64
        let publishedText: String
        
    }
    
    struct PlaylistEntry: Codable {
        
        let title: String
        let videoId: String
        let author: String
        let authorId: String
        let authorUrl: String
        
        let index: Int32
        let lengthSeconds: Int32
        
        let videoThumbnails: [InvidiousVideoThumbnail]
        
        
        
    }
    
    struct ChannelPlaylistEntry: Codable {
        
        let title: String
        let videoId: String
        let lengthSeconds: Int32
        let videoThumbnails: [InvidiousVideoThumbnail]
    }
}
