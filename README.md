# Google Books API Client Library for Swift

The Google Books API Client Library for Swift

# Usage

```swift
import GoogleBooksApiClient

let session = URLSession.shared
let client = GoogleBooksApiClient(session: session)
let task: URLSessionDataTask = client.invoke(
    GoogleBooksApi.VolumeRequest.Get(id: Id("EFXMMgEACAAJ")),
    onSuccess: { volume in
        NSLog("\(volume)")
    },
    onError: { error in
        NSLog("\(error)")
    }
)
```
