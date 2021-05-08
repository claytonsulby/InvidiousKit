//
//  Invidious.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

public class Invidious {
    
    public let instance: String
    public let timeout: TimeInterval
    
    private let fetcher: InvidiousFetcher
    
    init(instance: String, requestTimeout timeout: TimeInterval = 15) {
        self.instance = instance
        self.timeout = timeout
        self.fetcher = InvidiousFetcher(instance: instance, timeout: timeout)
    }

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

    public func getTrendingVideos(type: String? = nil, regionCode region: String? = nil, completionHandler: @escaping ([VideoPreview.ChannelVideo]?, InvidiousError?) -> Void) {
        fetcher.fetchTrending(type: type, region: region) { videos, error in
            if let videos = videos {
                completionHandler(videos.map { VideoPreview.ChannelVideo(from: $0) }, error)
                return
            }
            completionHandler(nil, error)
        }
    }

    public func getPopularVideos(completionHandler: @escaping ([VideoPreview.PopularVideo]?, InvidiousError?) -> Void) {
        fetcher.fetchPopular { videos, error in
            if let videos = videos {
                completionHandler(videos.map { VideoPreview.PopularVideo(from: $0) }, error)
                return
            }
            completionHandler(nil, error)
        }
    }

    public func getChannel(id: String, sortedBy sort: Channel.SortDescriptor = .newest, completionHandler: @escaping (Channel?, InvidiousError?) -> Void) {
        fetcher.fetchChannel(channelId: id) { channel, error in
            if let channel = channel {
                completionHandler(Channel(from: channel), error)
                return
            }
            completionHandler(nil, error)
        }
    }

    public func getChannelVideos(id: String, sortedBy sort: Channel.SortDescriptor = .newest, completionHandler: @escaping ([VideoPreview.ChannelVideo]?, InvidiousError?) -> Void) {
        fetcher.fetchChannelVideos(channelId: id) { videos, error in
            if let videos = videos {
                completionHandler(videos.map { VideoPreview.ChannelVideo(from: $0) }, error)
                return
            }
            completionHandler(nil, error)
        }
        
    }

    public func getChannelPlaylists(id: String, sortedBy sort: Channel.SortDescriptor, continuation: String? = nil, completionHandler: @escaping ([ChannelPlaylist]?, String?, InvidiousError?) -> Void) {
        fetcher.fetchChannelPlaylists(channelId: id, sortBy: sort.toString()) { reference, error in
            if let reference = reference {
                completionHandler(reference.playlists.map { ChannelPlaylist(from: $0) }, reference.continuation, error)
                return
            }
            completionHandler(nil, nil, error)
        }
    }

    public func getChannelComments(id: String, completionHandler: @escaping ([Comment]?, String?, InvidiousError?) -> Void) {
        fetcher.fetchChannelComments(channelId: id) { reference, error in
            if let reference = reference {
                completionHandler(reference.comments.map { Comment(from: $0) }, reference.continuation, error)
                return
            }
            completionHandler(nil, nil, error)
        }
    }

    public func getSearchSuggestions(searchQuery query: String, completionHandler: @escaping (String?, [String]?, InvidiousError?) -> Void) {
        fetcher.fetchSearchSuggestions(searchQuery: query) { reference, error in
            if let reference = reference {
                completionHandler(reference.query, reference.suggestions, error)
                return
            }
            completionHandler(nil, nil, error)
        }
        
    }

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
