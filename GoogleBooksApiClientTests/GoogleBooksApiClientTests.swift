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
        let task1 = client.invoke(
            GoogleBooksApi.VolumeRequest.Get(id: Id("EFXMMgEACAAJ")),
            onSuccess: { volume in
                NSLog("\(volume)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        task1.resume()
        let task2 = client.invoke(
            GoogleBooksApi.VolumeRequest.List(query: "Google"),
            onSuccess: { volumes in
                NSLog("\(volumes)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        task2.resume()
        let task3 = client.invoke(
            GoogleBooksApi.BookshelfRequest.Get(id: BookshelfId.favorites, userId: "113452853140207249483"),
            onSuccess: { bookshelf in
                NSLog("\(bookshelf)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        task3.resume()
        let task4 = client.invoke(
            GoogleBooksApi.BookshelfRequest.List(userId: "113452853140207249483"),
            onSuccess: { bookshelves in
                NSLog("\(bookshelves)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        task4.resume()
        let task5 = client.invoke(
            GoogleBooksApi.BookshelvesVolumesRequest.List(userId: "113452853140207249483", shelf: BookshelfId.favorites),
            onSuccess: { volumes in
                NSLog("\(volumes)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        task5.resume()
        sleep(4)
    }
    
}
