//
//  Comment.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Object responsible for storing comment data
public struct Comment {
    
    /// Initializes Playlist from JSON decoded response
    /// - Parameter comment: JSON decoded response from Invidious
    internal init(from comment: InvidiousComment) {
        self.author = comment.author
        self.authorId = comment.authorId
        self.authorThumbnails = comment.authorThumbnails.map { Channel.Icon(from: $0) }
        self.authorUrl = comment.authorUrl
        self.isEdited = comment.isEdited
        self.content = comment.content
        self.contentHtml = comment.contentHtml
        self.published = comment.published
        self.publishedText = comment.publishedText
        self.likeCount = comment.likeCount
        self.commentId = comment.commentId
        self.authorIsChannelOwner = comment.authorIsChannelOwner
        self.replyCount = comment.replies?.replyCount ?? -1
        self.replyContinuation = comment.replies?.continuation ?? ""
        self.creatorName = comment.commentHeart?.creatorName ?? ""
        self.creatorThumbnail = comment.commentHeart?.creatorThumbnail ?? ""
    }
    
    public let author: String
    public let authorThumbnails: [Channel.Icon]
    
    public let authorId: String
    public let authorUrl: String
    public let isEdited: Bool
    public let content: String
    public let contentHtml: String
    public let published: Int64
    public let publishedText: String
    public let likeCount: Int32
    public let commentId: String
    public let authorIsChannelOwner: Bool
    
    //replies
    public let replyCount: Int32
    public let replyContinuation: String
    
    //content heart ??
    public let creatorName: String?
    public let creatorThumbnail: String?
    
}
