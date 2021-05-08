//
//  FormattedStream.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct FormattedStream {
    
    /// Initializes FormattedStream from JSON decoded reponse
    /// - Parameter stream: JSON decoded response from Invidious
    internal init(from stream: InvidiousStreamFormat) {
        self.url = URL(string: stream.url)
        self.itag = stream.itag
        self.type = stream.type
        self.container = stream.container
        self.fps = stream.fps
        self.encoding = stream.encoding
        self.qualityLabel = stream.qualityLabel
        self.resolution = stream.resolution
        self.size = stream.size
    }
    
    public let url: URL?
    public let itag: String
    public let type: String
    public let container: String
    public let fps: Int32
    public let encoding: String
    public let qualityLabel: String
    public let resolution: String
    public let size: String
    
}
