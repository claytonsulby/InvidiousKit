import XCTest
@testable import InvidiousKit

final class InvidiousKitTests: XCTestCase {
    let timeout = 15
//    lazy var invidious = Invidious(instance: "https://invidious.fdn.fr", requestTimeout: TimeInterval(timeout))
    let invidious = Invidious.Cascading(instances: ["https://invidious.snopyta.org", "https://invidious.zee.li",  "https://invidiou.site", "https://invidious.fdn.fr"], sessionTimeout: 8)
    
    let videoId = "1EEakkh4ZG4"
    let channelId = "linustechtips"
    let playlistId = "PL8mG-RkN2uTyuEutQa79RZ0Q5u5gteUci"
    
    func testVideoFetch() {
        var exp: XCTestExpectation? = expectation(description: "Video GET Request")
        
        invidious.getVideo(id: videoId) { video, error in
            XCTAssertNotNil(video)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testCommentsFetch() {
        var exp: XCTestExpectation? = expectation(description: "Comments GET Request")
        
        invidious.getVideoComments(id: videoId) { count, comments, continuation, error in
            XCTAssertNotNil(count)
            XCTAssertNotNil(comments)
            XCTAssertNotNil(continuation)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testCaptionsFetch() {
        var exp: XCTestExpectation? = expectation(description: "Captions GET Request")
        
        invidious.getCaptions(id: videoId) { captions, error in
            XCTAssertNotNil(captions)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testTrendigFetch() {
        var exp: XCTestExpectation? = expectation(description: "Trending GET Request")
        
        invidious.getTrendingVideos(regionCode: "JP") { videos, error in
            XCTAssertNotNil(videos)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testPopularFetch() {
        var exp: XCTestExpectation? = expectation(description: "Popular GET Request")
        
        invidious.getPopularVideos { videos, error in
            XCTAssertNotNil(videos)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testChannelFetch() {
        var exp: XCTestExpectation? = expectation(description: "Channel GET Request")
        
        invidious.getChannel(id: channelId) { channel, error in
            XCTAssertNotNil(channel)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testChannelVideosFetch() {
        var exp: XCTestExpectation? = expectation(description: "Channel Videos GET Request")
        
        invidious.getChannelVideos(id: channelId, sortedBy: .newest) { videos, error in
            XCTAssertNotNil(videos)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testChannelPlaylistsFetch() {
        var exp: XCTestExpectation? = expectation(description: "Channel Playlists GET Request")
        
        invidious.getChannelPlaylists(id: channelId, sortedBy: .newest) { playlists, _, error in
            XCTAssertNotNil(playlists)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testChannelCommentsFetch() {
        var exp: XCTestExpectation? = expectation(description: "Channel Comments GET Request")
        
        invidious.getChannelComments(id: channelId) { comments, _, error in
            XCTAssertNotNil(comments)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testSearchSuggestionsFetch() {
        var exp: XCTestExpectation? = expectation(description: "Search Suggestions GET Request")
        
        invidious.getSearchSuggestions(searchQuery: "never gonna") { query, suggestions, error in
            XCTAssertNotNil(query)
            XCTAssert(!(suggestions?.isEmpty ?? false))
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testSearchResultsFetch() {
        var exp: XCTestExpectation? = expectation(description: "Search Results GET Request")
        
        invidious.getSearchResults(searchQuery: "never gonna give you up", sortedBy: .relevance) { results, error in
            XCTAssertNotNil(results)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    
    func testPlaylistFetch() {
        var exp: XCTestExpectation? = expectation(description: "Playlist GET Request")
        
        invidious.getPlaylist(id: playlistId) { playlist, error in
            XCTAssertNotNil(playlist)
            XCTAssertNil(error)
            exp?.fulfill()
            exp = nil
        }
        
        waitForExpectations(timeout: TimeInterval(timeout)) { error in
            print("\(String(describing: error?.localizedDescription))")
            exp = nil
        }
    }
    

    static var allTests = [
        ("testVideoFetch", testVideoFetch),
        ("testCommentsFetch", testCommentsFetch),
        ("testCaptionsFetch", testCaptionsFetch),
        ("testTrendingFetch", testTrendigFetch),
        ("testPopularFetch", testPopularFetch),
        ("testChannelFetch", testChannelFetch),
        ("testChannelVideosFetch", testChannelVideosFetch),
        ("testChannelPlaylistsFetch", testChannelPlaylistsFetch),
        ("testChannelCommentsFetch", testChannelCommentsFetch),
        ("testSearchSuggestionsFetch", testSearchSuggestionsFetch),
        ("testSearchResultsFetch", testSearchResultsFetch),
        ("testPlaylistFetch", testPlaylistFetch)
        
    ]
}
