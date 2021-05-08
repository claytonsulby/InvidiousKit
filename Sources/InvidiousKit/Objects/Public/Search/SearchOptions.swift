//
//  SearchOptions.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public protocol Searchable {
    
    var author: String { get }
    var authorId: String { get }
    var authorUrl: String { get }
    
}

public struct SearchOptions {
    
    public enum Sorting: String {
        case relevance = "relevance"
        case rating = "rating"
        case uploadDate = "upload_date"
        case viewCount = "view_count"
    }
    
    public enum Time: String {
        case lastHour = "hour"
        case today = "today"
        case thisWeek = "week"
        case thisMonth = "month"
        case thisYear = "year"
    }
    
    public enum Duration: String {
        case long = "long"
        case short = "short"
    }
    
    public enum AcceptableResultType: String {
        case video = "video"
        case playlist = "playlist"
        case channel = "channel"
        case all = "all"
    }
    
    public enum Feature: String {
        case hd = "hd"
        case hasSubtitles = "subtitles"
        case creativeCommons = "creative_commons"
        case threeDimensional = "3d"
        case live = "live"
        case purchased = "purchased"
        case threesixty = "360"
        case location = "location"
        case hdr = "hdr"
    }
}
