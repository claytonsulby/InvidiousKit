# InvidiousKit
Swift library for fetching data from Invidious

## Installation
InvidiousKit does not require any external dependecies and is available via [Swift Package Manager](https://github.com/apple/swift-package-manager)

```swift
// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "TestProject",
  dependencies: [
    .package(url: "https://github.com/borcd/InvidiousKit.git", .branch("main"))
  ],
  targets: [
    .target(name: "TestProject", dependencies: ["InvidiousKit"])
  ]
)
```

## Fetching data

First create an `Invidious` object instance
```swift
let invidious = Invidious(instance: "https://example.com", timeout: 20) //timeout in seconds, by default 15
//you can create an Invidious.Cascading instance which will cascade instances (if fetch on instance 1 fails, switch to instance 2 and try again...)
let invidious = Invidious.Cascading(instances: ["https://example.com", "https://example.net", "https://localhost"], sessionTimeout: 4)
```

Fetching videos (**GET** `/api/v1/videos/:id`, **GET** `/api/v1/channels/videos/:ucid`)
```swift
invidious.getVideo(id: "dQw4w9WgXcQ") { video, error in
    print(video?.author) //Official Rick Astley
}

invidious.getChannelVideos(id: "UCuAXFkgsw1L7xaCfnd5JJOw") { videos, error in
    print(videos?.first?.author) //Official Rick Astley
}
```

Feching channels (**GET** `/api/v1/channels/:ucid`)
```swift
invidious.getChannel(id: "UCuAXFkgsw1L7xaCfnd5JJOw") { channel, error in
    print(channel?.name) //Official Rick Astley
}
```

Fetching comments (**GET** `/api/v1/comments/:id`, **GET** `/api/v1/channels/comments/:ucid`)
```swift
invidious.getVideoComments(id: "dQw4w9WgXcQ") { count, comments, continuation, error in
    print(count!) //1575466
}

invidious.getChannelComments(id: "UCuAXFkgsw1L7xaCfnd5JJOw") { comments, continuation, error in
    print(comments?.first?.authorIsChannelOwner) //true
}
```

Fetching playlists (**GET** `/api/v1/playlists/:plid`, **GET** `/api/v1/channels/playlists/:ucid`)
```swift
invidious.getPlaylist(id: "PL8mG-RkN2uTyuEutQa79RZ0Q5u5gteUci") { playlist, error in
    print(playlist?.title) //Watch More Scrapyard Wars
}

invidious.getChannelPlaylists(id: "UCuAXFkgsw1L7xaCfnd5JJOw", sortedBy: .newest) { playlists, continuation, error in
    print(playlists?.count) //6
}
```

Fetching captions (**GET** `/api/v1/captions/:id`)
```swift
invidious.getCaptions(id: "1EEakkh4ZG4") { captions, error in
    print(captions?.count) //6
}
```

Fetching trending videos (**GET** `/api/v1/trending`)
```swift
invidious.getTrendingVideos(regionCode: "IE") { videos, error in
    print(videos?.count) //59
}
```

Fetching popular videos (**GET** `/api/v1/popular`)
```swift
invidious.getPopularVideos { videos, error in
    print(videos?.count) //40
}
```

Fetching search suggestions and results (**GET** `/api/v1/search/suggestions`, **GET** `/api/v1/search`)
```swift
invidious.getSearchSuggestions(searchQuery: "never") { query, suggestions, error in
    print(suggestions?.first?) //never gonna give you up
}

invidious.getSearchResults(searchQuery: "never gonna give you up", sortedBy: .relevance) { results, error in
    print((results?.first as? VideoPreview.SearchResult)?.author) //Official Rick Astley
}

```










