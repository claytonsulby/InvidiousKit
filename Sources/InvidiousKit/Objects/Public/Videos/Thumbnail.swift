//
//  Thumbnail.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public struct Thumbnail {
    
    public enum Quality: Equatable {
        
        case maxres
        case maxresdefault
        case sddefault
        case high
        case medium
        case def
        case middle
        case end
        case other(_ what: String)
        
        public static func fromString(quality: String) -> Self? {
            switch quality {
                case "maxres":
                    return .maxres
                case "maxresdefault":
                    return .maxresdefault
                case "sddefault":
                    return .sddefault
                case "high":
                    return .high
                case "medium":
                    return .medium
                case "default":
                    return .def
                case "def":
                    return .def
                case "middle":
                    return .middle
                case "end":
                    return .end
                default:
                    return .other(quality)
            }
        }
    }
    
    init(_ thumbnail: InvidiousVideoThumbnail) {
        self.quality = Quality.fromString(quality: thumbnail.quality)
        self.url = URL(string: thumbnail.url)
        self.width = thumbnail.width
        self.height = thumbnail.height
    }
    
    init(quality: String, url: String, width: Int32, height: Int32) {
        self.quality = Quality.fromString(quality: quality)
        self.url = URL(string: url)
        self.width = width
        self.height = height
    }
    
    public let quality: Self.Quality?
    public let url: URL?
    public let width: Int32
    public let height: Int32
    
}

