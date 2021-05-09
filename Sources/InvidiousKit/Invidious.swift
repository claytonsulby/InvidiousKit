//
//  Invidious.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public class Invidious {
    
    class Cascading: Invidious {
        
        public var instances: [String]
        
        public init(instances: [String], sessionTimeout timeout: TimeInterval = 5) {
            self.instances = instances
            super.init(instance: instances.first!, requestTimeout: timeout)
        }
        
        private func swap(with instance: String) {
            if !(instances.first == instance), let index = self.instances.firstIndex(of: instance) {
                instances.swapAt(0, index)
            }
        }
        
        override func getVideo(id: String, completionHandler: @escaping (Video?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchVideo(videoId: id) { [weak self] video, error in
                    if let video = video {
                        completionHandler(Video(from: video), error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getVideoComments(id: String, completionHandler: @escaping (Int32?, [Comment]?, String?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchComments(videoId: id) { [weak self] comments, error in
                    if let comments = comments {
                        completionHandler(comments.commentCount, comments.comments.map { Comment(from: $0)}, comments.continuation, error)
                        self?.swap(with: instance)
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, nil, nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getCaptions(id: String, completionHandler: @escaping ([Caption]?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchCaptions(videoId: id) { [weak self] captions, error in
                    if let captions = captions {
                        completionHandler(captions.map { Caption(from: $0) }, error)
                        self?.swap(with: instance)
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getTrendingVideos(type: String? = nil, regionCode region: String? = nil, completionHandler: @escaping ([VideoPreview.ChannelVideo]?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchTrending(type: type, region: region) { [weak self] videos, error in
                    if let videos = videos {
                        completionHandler(videos.map { VideoPreview.ChannelVideo(from: $0) }, error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getPopularVideos(completionHandler: @escaping ([VideoPreview.PopularVideo]?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchPopular { [weak self] videos, error in
                    if let videos = videos {
                        completionHandler(videos.map { VideoPreview.PopularVideo(from: $0) }, error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getChannel(id: String, sortedBy sort: Channel.SortDescriptor = .newest, completionHandler: @escaping (Channel?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchChannel(channelId: id) { [weak self] channel, error in
                    if let channel = channel {
                        completionHandler(Channel(from: channel), error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getChannelVideos(id: String, sortedBy sort: Channel.SortDescriptor = .newest, completionHandler: @escaping ([VideoPreview.ChannelVideo]?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchChannelVideos(channelId: id) { [weak self] videos, error in
                    if let videos = videos {
                        completionHandler(videos.map { VideoPreview.ChannelVideo(from: $0) }, error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getChannelPlaylists(id: String, sortedBy sort: Channel.SortDescriptor, continuation: String? = nil, completionHandler: @escaping ([ChannelPlaylist]?, String?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchChannelPlaylists(channelId: id) { [weak self] reference, error in
                    if let reference = reference {
                        completionHandler(reference.playlists.map { ChannelPlaylist(from: $0) }, reference.continuation, error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1  {
                            completionHandler(nil, nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getChannelComments(id: String, completionHandler: @escaping ([Comment]?, String?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchChannelComments(channelId: id) { [weak self] reference, error in
                    if let reference = reference {
                        completionHandler(reference.comments.map { Comment(from: $0) }, reference.continuation, error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getSearchSuggestions(searchQuery query: String, completionHandler: @escaping (String?, [String]?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchSearchSuggestions(searchQuery: query) { [weak self] reference, error in
                    if let reference = reference {
                        completionHandler(reference.query, reference.suggestions, error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getSearchResults(searchQuery query: String, page: Int = 1, sortedBy sort: SearchOptions.Sorting? = nil, SortedByTime time: SearchOptions.Time? = nil, duration: SearchOptions.Duration? = nil, expectedResultType type: SearchOptions.AcceptableResultType = .all, expectedFeatures features: [SearchOptions.Feature]? = nil, searchRegion region: String? = nil, completionHandler: @escaping ([Searchable]?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchSearchResults(searchQuery: query, page: Int32(page), soryBy: sort?.rawValue, timeSort: time?.rawValue, duration: duration?.rawValue, type: type.rawValue, features: features?.map { $0.rawValue }, region: region) { [weak self] searchResults, error in
                    
                    if let searchResults = searchResults {
                        let results = searchResults.compactMap { result -> Searchable? in
                            if result is InvidiousChannel.SearchResult {
                                return ChannelPreview.SearchResult(from: result as! InvidiousChannel.SearchResult) as Searchable
                            } else if result is InvidiousVideoPreview.ChannelVideo {
                                return VideoPreview.SearchResult(from: result as! InvidiousVideoPreview.ChannelVideo) as Searchable
                            } else if result is InvidiousChannelPlaylist {
                                return Playlist.SearchResult(from: result as! InvidiousChannelPlaylist) as Searchable
                            }
                            return nil
                        }
                        completionHandler(results, error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count - 1 {
                            completionHandler(nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
        override func getPlaylist(id: String, page: Int = 1, completionHandler: @escaping (Playlist?, InvidiousError?) -> Void) {
            var counter = 0
            instances.forEach { instance in
                let temporaryFetcher = InvidiousFetcher(instance: instance, timeout: super.timeout)
                temporaryFetcher.fetchPlaylist(playlistId: id) { [weak self] playlist, error in
                    if let playlist = playlist {
                        completionHandler(Playlist(from: playlist), error)
                        self?.swap(with: instance)
                        return
                    } else {
                        if counter == self!.instances.count {
                            completionHandler(nil, error)
                            return
                        }
                        counter += 1
                    }
                }
            }
        }
        
    }
    
    public let instance: String
    public let timeout: TimeInterval
    
    private let fetcher: InvidiousFetcher
    
    /// Initializes the Invidious object used to fetch data from a choosen instance
    /// - Parameters:
    ///   - instance: URL String of an Invidious instance
    ///   - timeout: Data request timeout in seconds
    public init(instance: String, requestTimeout timeout: TimeInterval = 15) {
        self.instance = instance
        self.timeout = timeout
        self.fetcher = InvidiousFetcher(instance: instance, timeout: timeout)
    }
    
    /// Fetches video data from Invidious
    /// - Parameters:
    ///   - id: Video id (11 Characters)
    ///   - completionHandler: Closure called when the fetch is completed, contains optional `Video` and `InvidiousError` objects
    public func getVideo(id: String, completionHandler: @escaping (Video?, InvidiousError?) -> Void) {
        fetcher.fetchVideo(videoId: id) { video, error in
            if let video = video {
                completionHandler(Video(from: video), error)
                return
            }
            completionHandler(nil, error)
            return
        }
    }
    
    /// Fetches comments of a video
    /// - Parameters:
    ///   - id: Video id (11 Characters)
    ///   - completionHandler: Closure called when the fetch is completed, contains the following optional properties: Number of comments, Array of `Comment` objects, continuation `String` and `InvidiousError`
    public func getVideoComments(id: String, completionHandler: @escaping (Int32?, [Comment]?, String?, InvidiousError?) -> Void) {
        fetcher.fetchComments(videoId: id) { comments, error in
            if let comments = comments {
                completionHandler(comments.commentCount, comments.comments.map { Comment(from: $0)}, comments.continuation, error)
                return
            }
            completionHandler(nil, nil, nil, error)
            return
        }
    }
    
    /// Fetches captions for a video
    /// - Parameters:
    ///   - id: Video id (11 Characters)
    ///   - completionHandler: Closure called when the fetch is completed, contains optional array of `Caption` objects and `InvidiousError`
    public func getCaptions(id: String, completionHandler: @escaping ([Caption]?, InvidiousError?) -> Void) {
        fetcher.fetchCaptions(videoId: id) { captions, error in
            if let captions = captions {
                completionHandler(captions.map { Caption(from: $0) }, error)
                return
            }
            completionHandler(nil, error)
            return
        }
    }
    
    /// Fetches trending videos
    /// - Parameters:
    ///   - type: Type filer (news, sport, technology...)
    ///   - region: Two character region code (CA, IE, CH...)
    ///   - completionHandler: Closure called when the fetch is completed, contains optional array of `VideoPreview` objects and `InvidiousError`
    public func getTrendingVideos(type: String? = nil, regionCode region: String? = nil, completionHandler: @escaping ([VideoPreview.ChannelVideo]?, InvidiousError?) -> Void) {
        fetcher.fetchTrending(type: type, region: region) { videos, error in
            if let videos = videos {
                completionHandler(videos.map { VideoPreview.ChannelVideo(from: $0) }, error)
                return
            }
            completionHandler(nil, error)
        }
    }
    
    /// Fetches videos popular on that instance
    /// - Parameter completionHandler: Closure called when the fetch is completed, contains optional array of `VideoPreview` objects and `InvidiousError`
    public func getPopularVideos(completionHandler: @escaping ([VideoPreview.PopularVideo]?, InvidiousError?) -> Void) {
        fetcher.fetchPopular { videos, error in
            if let videos = videos {
                completionHandler(videos.map { VideoPreview.PopularVideo(from: $0) }, error)
                return
            }
            completionHandler(nil, error)
        }
    }
    
    /// Fetches channel data from Invidious
    /// - Parameters:
    ///   - id: Channel id
    ///   - sort: How items should be sorted (oldest, newest, popular)
    ///   - completionHandler: Closure called when the fetch is completed, contains optional `Channel` and `InvidiousError` objects
    public func getChannel(id: String, sortedBy sort: Channel.SortDescriptor = .newest, completionHandler: @escaping (Channel?, InvidiousError?) -> Void) {
        fetcher.fetchChannel(channelId: id) { channel, error in
            if let channel = channel {
                completionHandler(Channel(from: channel), error)
                return
            }
            completionHandler(nil, error)
        }
    }
    
    /// Fetches all videos for a select channel
    /// - Parameters:
    ///   - id: Channel id
    ///   - sort: How items should be sorted (oldest, newest, popular)
    ///   - completionHandler: Closure called when the fetch is completed, contains optional array of `VideoPreview` objects and `InvidiousError`
    public func getChannelVideos(id: String, sortedBy sort: Channel.SortDescriptor = .newest, completionHandler: @escaping ([VideoPreview.ChannelVideo]?, InvidiousError?) -> Void) {
        fetcher.fetchChannelVideos(channelId: id) { videos, error in
            if let videos = videos {
                completionHandler(videos.map { VideoPreview.ChannelVideo(from: $0) }, error)
                return
            }
            completionHandler(nil, error)
        }
        
    }

    /// Fetches all playlists for a channel
    /// - Parameters:
    ///   - id: Channel id
    ///   - sort: How items should be sorted (oldest, newest, popular)
    ///   - continuation: Continuation string
    ///   - completionHandler: Closure called when the fetch is completed, contains optional array of `ChannelPlaylist` objects and `InvidiousError`
    public func getChannelPlaylists(id: String, sortedBy sort: Channel.SortDescriptor, continuation: String? = nil, completionHandler: @escaping ([ChannelPlaylist]?, String?, InvidiousError?) -> Void) {
        fetcher.fetchChannelPlaylists(channelId: id, sortBy: sort.toString()) { reference, error in
            if let reference = reference {
                completionHandler(reference.playlists.map { ChannelPlaylist(from: $0) }, reference.continuation, error)
                return
            }
            completionHandler(nil, nil, error)
        }
    }
    
    /// Fetches all comments for a channel
    /// - Parameters:
    ///   - id: Channel id
    ///   - completionHandler: Closure called when the fetch is completed, contains following optional values: array of `Comment` objects, continuation `String` and `InvidiousError`
    public func getChannelComments(id: String, completionHandler: @escaping ([Comment]?, String?, InvidiousError?) -> Void) {
        fetcher.fetchChannelComments(channelId: id) { reference, error in
            if let reference = reference {
                completionHandler(reference.comments.map { Comment(from: $0) }, reference.continuation, error)
                return
            }
            completionHandler(nil, nil, error)
        }
    }
    
    /// Fetches search suggestions for a given search query
    /// - Parameters:
    ///   - query: Search query on which the suggestions are based on
    ///   - completionHandler: Closure called when the fetch is completed, contains the following optional values: search query `String`, array of search suggestion `String`s and `InvidiousError`
    public func getSearchSuggestions(searchQuery query: String, completionHandler: @escaping (String?, [String]?, InvidiousError?) -> Void) {
        fetcher.fetchSearchSuggestions(searchQuery: query) { reference, error in
            if let reference = reference {
                completionHandler(reference.query, reference.suggestions, error)
                return
            }
            completionHandler(nil, nil, error)
        }
        
    }
    
    /// Fetches search results for a given search query
    /// - Parameters:
    ///   - query: Search query
    ///   - page: Page of results that should return (if multiple pages)
    ///   - sort: How the results should be sorted (relevance, rating, upload date, view count)
    ///   - time: Specifies the timeframe from which the results should be (last hour, today, this week...)
    ///   - duration: Filiters long or short videos
    ///   - type: Expected result type (video, channel, playlist, all)
    ///   - features: Additional features
    ///   - region: Two character region code (CA, IE, CH...)
    ///   - completionHandler: Closure called when the fetch is completed, contains optional array of `Searchable` items and `InvidiousError` objects
    public func getSearchResults(searchQuery query: String, page: Int = 1, sortedBy sort: SearchOptions.Sorting? = nil, SortedByTime time: SearchOptions.Time? = nil, duration: SearchOptions.Duration? = nil, expectedResultType type: SearchOptions.AcceptableResultType = .all, expectedFeatures features: [SearchOptions.Feature]? = nil, searchRegion region: String? = nil, completionHandler: @escaping ([Searchable]?, InvidiousError?) -> Void) {
        
        fetcher.fetchSearchResults(searchQuery: query, page: Int32(page), soryBy: sort?.rawValue, timeSort: time?.rawValue, duration: duration?.rawValue, type: type.rawValue, features: features?.map { $0.rawValue }, region: region) { searchResults, error in
            if let searchResults = searchResults {
                let results = searchResults.compactMap { result -> Searchable? in
                    if result is InvidiousChannel.SearchResult {
                        return ChannelPreview.SearchResult(from: result as! InvidiousChannel.SearchResult) as Searchable
                    } else if result is InvidiousVideoPreview.ChannelVideo {
                        return VideoPreview.SearchResult(from: result as! InvidiousVideoPreview.ChannelVideo) as Searchable
                    } else if result is InvidiousChannelPlaylist {
                        return Playlist.SearchResult(from: result as! InvidiousChannelPlaylist) as Searchable
                    }
                    return nil
                }
                completionHandler(results, error)
                return
            }
            completionHandler(nil, error)
        }
    }

    /// Fetches video data from Invidious
    /// - Parameters:
    ///   - id: Playlist id
    ///   - completionHandler: Closure called when the fetch is completed, contains optional `Playlist` and `InvidiousError` objects
    public func getPlaylist(id: String, page: Int = 1, completionHandler: @escaping (Playlist?, InvidiousError?) -> Void) {
        fetcher.fetchPlaylist(playlistId: id) { playlist, error in
            if let playlist = playlist {
                completionHandler(Playlist(from: playlist), error)
                return
            }
            completionHandler(nil, error)
            return
        }
    }

}
