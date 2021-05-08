//
//  InvidiousPlaylist.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct InvidiousPlaylist: Codable {
    
    let title: String
    let playlistId: String
    
    let author: String
    let authorId: String
    let authorThumbnails: [InvidiousAuthorThumbnail]
    
    let description: String
    let descriptionHtml: String
    
    let videoCount: Int32
    let viewCount: Int64
    let updated: Int64
    
    let videos: [InvidiousVideoPreview.PlaylistEntry]
}

public struct InvidiousChannelPlaylist: Codable {
    
    let title: String
    let playlistId: String
    let author: String
    let authorId: String
    let authorUrl: String
    
    let videoCount: Int32
    let videos: [InvidiousVideoPreview.ChannelPlaylistEntry]
}
