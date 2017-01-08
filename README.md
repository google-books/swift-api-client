# Google Books API Client Library for Swift

![CocoaPods Version](https://img.shields.io/cocoapods/v/GoogleBooksApiClient.svg?style=flat)
[![License](https://img.shields.io/cocoapods/l/BadgeSwift.svg?style=flat)](/LICENSE)
![Swift Version](https://img.shields.io/badge/Swift-3.0-green.svg)

The Google Books API Client Library for Swift

## Installation

The supported options:

### CocoaPods

Add this to Podfile

```
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'GoogleBooksApiClient'
end
```

```
$ pod install
```

### Carthage

Add this to Cartfile

```
github "google-books/swift-api-client"
```

```
$ carthage update
```


## How to use

The library makes it simple to call Google Books APIs.

```swift
import GoogleBooksApiClient

let session = URLSession.shared
let client = GoogleBooksApiClient(session: session)
```

### Volume
#### list

```swift
let req = GoogleBooksApi.VolumeRequest.List(query: "Google")
let task: URLSessionDataTask = client.invoke(
    req,
    onSuccess: { volumes in NSLog("\(volumes)" },
    onError: { error in NSLog("\(error)") }
)
```

### Mylibraly.Bookshlves
#### addVolume

```swift
let authInfo = GoogleBooksApiAuthInfo(apiKey: nil, authToken: "YOUR_AUTH_TOKEN")
let req = GoogleBooksApi.MyLibraryBookshelvesRequest.AddVolume(
    shelf: BookshelfId.haveRead,
    volumeId: Id("VOLUME_ID"),
    authInfo: authInfo
)
let task: URLSessionDataTask = client.invoke(
    req,
    onSuccess: { volumes in NSLog("\(volumes)" },
    onError: { error in NSLog("\(error)") }
)
```

# License

MIT
