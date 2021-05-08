//
//  AudioStream.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct AudioStream {
    
    internal init?(from stream: InvidiousAdaptiveFormat) {
        if !stream.type.starts(with: "audio") {
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
                self.encoding = AudioEncoding.getFromString(string: enc)
            } else {
                self.encoding = nil
            }
        }
    }
    
    
    public enum AudioEncoding {
        case aac
        case opus
        case other(encoding: String)
        
        public static func getFromString(string: String) -> Self {
            switch string {
                case "aac":
                    return .aac
                case "opus":
                    return .opus
                default:
                    return .other(encoding: string)
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
    public let encoding: AudioEncoding?
    
}
