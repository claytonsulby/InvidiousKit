//
//  InvidiousFetcher.swift
//  
//
//  Created on 07/05/2021
//


import Foundation

internal class InvidiousFetcher {
    
    init(instance: String, timeout: TimeInterval) {
        self.instance = instance
        self.timeout = timeout
    }
    
    let instance: String
    let timeout: TimeInterval
    
    private var globalDataTask: URLSessionDataTask? {
        didSet {
            oldValue?.cancel()
            globalDataTask?.resume()
        }
    }
    
    func fetchVideo(videoId id: String, callbackHandler: @escaping (InvidiousVideo?, InvidiousError?) -> Void) {
        guard id.count == 11 else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid Video ID. Expected 11 characters, got \(id.count).", data: id.data(using: .utf8)))
            return
        }
        
        guard let url = URL(string: "\(instance)/api/v1/videos/\(id)") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    if let video = try? JSONDecoder().decode(InvidiousVideo.self, from: data) {
                        if video.error == nil {
                            callbackHandler(video, nil)
                        } else {
                            callbackHandler(video, .suppliedErrorField(message: video.error!, data: data))
                        }
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
    }
    
    func fetchComments(videoId id: String, callbackHandler: @escaping (InvidiousCommentsReference?, InvidiousError?) -> Void) {
        guard id.count == 11 else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid Video ID. Expected 11 characters, got \(id.count).", data: id.data(using: .utf8)))
            return
        }
        
        guard let url = URL(string: "\(instance)/api/v1/comments/\(id)") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    if let comments = try? JSONDecoder().decode(InvidiousCommentsReference.self, from: data) {
                        if comments.error == nil {
                            callbackHandler(comments, nil)
                        } else {
                            callbackHandler(comments, .suppliedErrorField(message: comments.error!, data: data))
                        }
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
        
    }
    
    func fetchCaptions(videoId id: String, callbackHandler: @escaping ([InvidiousCaption]?, InvidiousError?) -> Void) {
        guard id.count == 11 else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid Video ID. Expected 11 characters, got \(id.count).", data: id.data(using: .utf8)))
            return
        }
        
        guard let url = URL(string: "\(instance)/api/v1/captions/\(id)") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    if let decodedData = String(data: data, encoding: .utf8)  {
                        guard let captionsArray = Self.convertToDictionary(string: decodedData)?["captions"] as? Array<Any> else {
                            callbackHandler(nil, .decodingError(message: "", data: data))
                            return
                        }
                        let captions = captionsArray.compactMap { element -> InvidiousCaption? in
                            if let entry = element as? NSDictionary {
                                return InvidiousCaption(label: entry["label"] as! String, languageCode: entry["languageCode"] as! String, url: entry["url"] as! String)
                            }
                            return nil
                        }
                        callbackHandler(captions, nil)
                        return
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
        
    }
    
    func fetchTrending(type: String? = nil, region: String? = nil, callbackHandler: @escaping ([InvidiousVideoPreview.ChannelVideo]?, InvidiousError?) -> Void) {
        
        var urlString = "\(instance)/api/v1/trending"
        
        if type != nil && region != nil {
            urlString = "\(urlString)?type=\(type!)&region=\(region!)"
        } else if type != nil {
            urlString = "\(urlString)?type=\(type!)"
        } else if region != nil {
            urlString = "\(urlString)?region=\(region!)"
        }
        
        guard let url = URL(string: urlString) else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    
                    if let trendingVideos = try? JSONDecoder().decode([InvidiousVideoPreview.ChannelVideo].self, from: data) {
                        callbackHandler(trendingVideos, nil)
                        return
                    } else {
                        if let dict = try? JSONDecoder().decode([String: String].self, from: data) {
                            guard (dict["error"] == nil) else {
                                callbackHandler(nil, .suppliedErrorField(message: dict["error"]!, data: data))
                                return
                            }
                        }
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
        
    }
    
    func fetchPopular(callbackHandler: @escaping ([InvidiousVideoPreview.PopularVideo]?, InvidiousError?) -> Void) {
        
        guard let url = URL(string: "\(instance)/api/v1/popular") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    if let videos = try? JSONDecoder().decode([InvidiousVideoPreview.PopularVideo].self, from: data) {
                        callbackHandler(videos, nil)
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
    }
    
    func fetchChannel(channelId id: String, sortBy sort: String = "newest", callbackHandler: @escaping (InvidiousChannel?, InvidiousError?) -> Void) {
        
        guard let url = URL(string: "\(instance)/api/v1/channels/\(id)") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    if let channel = try? JSONDecoder().decode(InvidiousChannel.self, from: data) {
                        if channel.error == nil {
                            callbackHandler(channel, nil)
                        } else {
                            callbackHandler(nil, .suppliedErrorField(message: channel.error!, data: data))
                        }
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
    }
    
    func fetchChannelVideos(channelId id: String, sortBy sort: String = "newest", callbackHandler: @escaping ([InvidiousVideoPreview.ChannelVideo]?, InvidiousError?) -> Void) {
        
        if sort != "newest" && sort != "oldest" && sort != "popular" {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid sort description, expected 'newest', 'oldest', or 'popular', got \(sort.lowercased())", data: nil))
            return
        }
        
        guard let url = URL(string: "\(instance)/api/v1/channels/videos/\(id)?sort_by=\(sort.lowercased())") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    if let videos = try? JSONDecoder().decode([InvidiousVideoPreview.ChannelVideo].self, from: data) {
                        callbackHandler(videos, nil)
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
    }
    
    func fetchChannelPlaylists(channelId id: String, sortBy sort: String = "newest", continuation: String? = nil, callbackHandler: @escaping (InvidiousChannelPlaylistsReference?, InvidiousError?) -> Void) {
        
        var urlString = "\(instance)/api/v1/channels/playlists/\(id)?sort_by=\(sort)"
        
        if sort != "newest" && sort != "oldest" && sort != "popular" {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid sort description, expected 'newest', 'oldest', or 'popular', got \(sort.lowercased())", data: nil))
        }

        if continuation != nil {
            urlString.append("&continuation=\(continuation!)")
        }
        
        guard let url = URL(string: urlString) else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    
                    if let playlistsReference = try? JSONDecoder().decode(InvidiousChannelPlaylistsReference.self, from: data) {
                        callbackHandler(playlistsReference, nil)
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
        
    }
    
    func fetchChannelComments(channelId id: String, callbackHandler: @escaping (InvidiousCommentsReference.ChannelComments?, InvidiousError?) -> Void) {
        
        guard let url = URL(string: "\(instance)/api/v1/channels/comments/\(id)") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    
                    if let playlistsReference = try? JSONDecoder().decode(InvidiousCommentsReference.ChannelComments.self, from: data) {
                        if playlistsReference.error == nil {
                            callbackHandler(playlistsReference, nil)
                        } else {
                            callbackHandler(playlistsReference, .suppliedErrorField(message: playlistsReference.error!, data: data))
                        }
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
    }
    
    func fetchSearchSuggestions(searchQuery query: String, callbackHandler: @escaping (InvidiousSearchReference.Suggestions?, InvidiousError?) -> Void) {
        
        guard let encodedSearchQuery = query.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid search query", data: nil))
            return
        }
        
        guard let url = URL(string: "\(instance)/api/v1/search/suggestions?q=\(encodedSearchQuery)") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    
                    if let suggestionsReference = try? JSONDecoder().decode(InvidiousSearchReference.Suggestions.self, from: data) {
                        if suggestionsReference.error == nil {
                            callbackHandler(suggestionsReference, nil)
                        } else {
                            callbackHandler(suggestionsReference, .suppliedErrorField(message: suggestionsReference.error!, data: data))
                        }
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
            
        }
        
    }
    
    func fetchSearchResults(searchQuery query: String, page: Int32 = 1, soryBy sort: String? = nil, timeSort when: String? = nil, duration: String? = nil, type: String = "all", features: [String]? = nil, region: String? = nil, callbackHandler: @escaping (Array<Any>?, InvidiousError?) -> Void) {
        
        guard let encodedSearchQuery = query.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid search query", data: nil))
            return
        }
        
        var urlString = "\(instance)/api/v1/search?q=\(encodedSearchQuery)&page=\(page)&type=\(type)"
        
        if sort != nil {
            urlString = "\(urlString)&sort=\(sort!)"
        }
        if when != nil {
            urlString = "\(urlString)&date=\(when!)"
        }
        if duration != nil {
            urlString = "\(urlString)&duration=\(duration!)"
        }
        if features != nil {
            urlString = "\(urlString)&features=\(features!.joined(separator: ","))"
        }
        if region != nil {
            urlString = "\(urlString)&region=\(region!)"
        }
        
        guard let url = URL(string: urlString) else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    
                    if let results = Self.convertToArray(data: data) {
                        let resultsMap = results.compactMap { value -> Any? in
                            if let dict = value as? NSDictionary {
                                if let dictData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                                    let dataType = dict["type"] as! String
                                    switch dataType {
                                    case "video":
                                        guard let video = try? JSONDecoder().decode(InvidiousVideoPreview.ChannelVideo.self, from: dictData) else { return nil }
                                        return video
                                    case "channel":
                                        guard let channel = try? JSONDecoder().decode(InvidiousChannel.SearchResult.self, from: dictData) else { return nil }
                                        return channel
                                    case "playlist":
                                        guard let playlist = try? JSONDecoder().decode(InvidiousChannelPlaylist.self, from: dictData) else { return nil }
                                        return playlist
                                    default:
                                        return nil
                                    }
                                }
                            }
                            return nil
                        }
                        callbackHandler(resultsMap, nil)
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
            
        }
        
    }
    
    func fetchPlaylist(playlistId id: String, page: Int = 1, callbackHandler: @escaping (InvidiousPlaylist?, InvidiousError?) -> Void) {
        
        guard let url = URL(string: "\(instance)/api/v1/playlists/\(id)?page=\(page)") else {
            callbackHandler(nil, .invalidDataSupplied(message: "Invalid URL", data: nil))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: timeout)
        
        globalDataTask = URLSession.shared.dataTask(with: request) { optionalData, response, error in
            if (error as? URLError)?.code == .timedOut {
                callbackHandler(nil, .requestTimeout(data: optionalData))
                return
            }
            
            if let error = error as? URLError {
                callbackHandler(nil, .invalidDataReturned(message: "Error [\(String(describing: error.errorCode))]: \(String(describing: error.localizedDescription))", data: optionalData))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data = optionalData else {
                        callbackHandler(nil, .decodingError(message: "Could not Convert Optional<Data> into Data", data: optionalData))
                        return
                    }
                    if let playlist = try? JSONDecoder().decode(InvidiousPlaylist.self, from: data) {
                        callbackHandler(playlist, nil)
                    } else {
                        callbackHandler(nil, .decodingError(message: "Could not decode data", data: data))
                    }
                    
                } else {
                    callbackHandler(nil, .invalidDataReturned(message: "Received HTTP status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) (Expected 200 OK)", data: optionalData))
                    return
                }
            } else {
                callbackHandler(nil, .decodingError(message: "Failed to cast URLResponse to HTTPURLResponse", data: optionalData))
            }
        }
    }
    
    
    private static func convertToDictionary(string json: String) -> [String: Any]? {
        if let data = json.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            } catch (let error) {
                print(error)
            }
        }
        return nil
    }
    
    private static func convertToDictionary(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any]
        } catch (let error) {
            print(error)
        }
        return nil
    }
    
    private static func convertToArray(data: Data) -> NSArray? {
        do {
            let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? NSArray
            return obj
        } catch (let error) {
            print(error)
        }
        return nil
    }
    
    
}
