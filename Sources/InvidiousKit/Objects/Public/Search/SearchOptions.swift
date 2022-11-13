//
//  SearchOptions.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

/// Protocol that all items that can be returned from search conform to
public protocol Searchable {
    
    var author: String { get }
    var authorId: String { get }
    var authorUrl: String { get }
    var id: String { get }
    var title: String { get }
    var type:SearchOptions.AcceptableResultType { get }
    
}

/// Collection of enums that dictate how the search operation should be filtered
public struct SearchOptions {
    
    /// Dictates how the returned data should be sorted
    public enum Sorting: String, CaseIterable {
        case relevance = "relevance"
        case rating = "rating"
        case uploadDate = "upload_date"
        case viewCount = "view_count"
    }
    
    /// Filter that dictates, that only entries from a select timeframe are returned
    public enum Time: String, CaseIterable {
        case lastHour = "hour"
        case today = "today"
        case thisWeek = "week"
        case thisMonth = "month"
        case thisYear = "year"
    }
    
    /// Dictates videos in what duration are allowed to be returned
    public enum Duration: String, CaseIterable {
        case long = "long"
        case short = "short"
    }
    
    /// Filter that dictates which result types are acceptable
    public enum AcceptableResultType: String, CaseIterable {
        case video = "video"
        case playlist = "playlist"
        case channel = "channel"
        case all = "all"
    }
    
    /// Any additional features that may be requested
    public enum Feature: String, CaseIterable {
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
