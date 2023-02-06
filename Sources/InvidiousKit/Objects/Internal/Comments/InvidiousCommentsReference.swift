//
//  InvidiousCommentsReference.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

struct InvidiousCommentsReference: Codable, StringError {
    
    struct ChannelComments: Codable {
        let authorId: String
        let comments: [InvidiousComment]
        let continuation: String?
        let error: String?
    }
    
    let commentCount: Int32?
    let videoId: String
    let comments: [InvidiousComment]
    let continuation: String?
    let error: String?
}
