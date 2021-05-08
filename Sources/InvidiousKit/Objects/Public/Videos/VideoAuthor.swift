//
//  VideoAuthor.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct VideoAuthor: Identifiable {
    
    internal init(name: String, id: String, url: String, icons: [InvidiousAuthorThumbnail]) {
        self.name = name
        self.id = id
        self.url = url
        var thumbnailArray = [Channel.Icon]()
        for icon in icons {
            thumbnailArray.append(Channel.Icon(from: icon))
        }
        self.icons = thumbnailArray
        
    }
    
    public let name: String
    public let id: String
    public let url: String
    public let icons: [Channel.Icon]
    
}
