//
//  VideoStream.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct VideoStream {
    
    internal init?(from stream: InvidiousAdaptiveFormat) {
        if !stream.type.starts(with: "video") {
            return nil
        } else {
            self.index = stream.index
            self.bitrate = stream.bitrate
            self.url = stream.url
            self.itag = stream.itag
            self.type = stream.type
            self.clen = stream.clen
            self.lmt = stream.lmt
            self.projectionType = stream.projectionType
            if let cont = stream.container {
                self.container = cont
            } else {
                self.container = nil
            }
            if let enc = stream.encoding {
                self.encoding = VideoEncoding.getFromString(string: enc)
            } else {
                self.encoding = nil
            }
            self.qualityLabel = stream.qualityLabel //both (+resolution) are elements of video but not audio
            self.resolution = stream.resolution
        }
    }
    
    
    public enum VideoEncoding {
        case h264
        case vp9
        case other(_ what: String)
        
        public static func getFromString(string: String) -> Self {
            switch string {
                case "h264":
                    return .h264
                case "vp9":
                    return .vp9
                default:
                    return .other(string)
            }
        }
    }
    
    public let index: String
    public let bitrate: String
    public let url: String
    public let itag: String
    public let type: String
    public let clen: String
    public let lmt: String
    public let projectionType: String
    public let container: String?
    public let encoding: VideoEncoding?
    public let qualityLabel: String?
    public let resolution: String?
    
    
}
