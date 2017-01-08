import XCTest
@testable import GoogleBooksApiClient

class GoogleBooksApiClientTests: XCTestCase {
    
    private let client: GoogleBooksApiClient = { _ -> GoogleBooksApiClient in
        let session = URLSession.shared
        return GoogleBooksApiClient(session: session)
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        _ = client.invoke(
            GoogleBooksApi.VolumeRequest.Get(id: Id("EFXMMgEACAAJ")),
            onSuccess: { volume in
                NSLog("\(volume)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        _ = client.invoke(
            GoogleBooksApi.VolumeRequest.List(query: "Google"),
            onSuccess: { volumes in
                NSLog("\(volumes)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        _ = client.invoke(
            GoogleBooksApi.BookshelfRequest.Get(id: BookshelfId.favorites, userId: "113452853140207249483"),
            onSuccess: { bookshelf in
                NSLog("\(bookshelf)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        _ = client.invoke(
            GoogleBooksApi.BookshelfRequest.List(userId: "113452853140207249483"),
            onSuccess: { bookshelves in
                NSLog("\(bookshelves)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        _ = client.invoke(
            GoogleBooksApi.BookshelvesVolumesRequest.List(userId: "113452853140207249483", shelf: BookshelfId.favorites),
            onSuccess: { volumes in
                NSLog("\(volumes)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        sleep(4)
    }
    
}
