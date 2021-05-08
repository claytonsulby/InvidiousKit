//
//  InvidiousComment.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousComment: Codable {
    
    struct CommentHeart: Codable {
        let creatorThumbnail: String
        let creatorName: String
    }
    
    struct Replies: Codable {
        
        let replyCount: Int32
        let continuation: String
    }
    
    let author: String
    let authorThumbnails: [InvidiousAuthorThumbnail]
    
    let authorId: String
    let authorUrl: String
    let isEdited: Bool
    let content: String
    let contentHtml: String
    let published: Int64
    let publishedText: String
    let likeCount: Int32
    let commentId: String
    let authorIsChannelOwner: Bool

//    //TODO: - Attatchments

    let commentHeart: Self.CommentHeart?
    let replies: Self.Replies?

}
