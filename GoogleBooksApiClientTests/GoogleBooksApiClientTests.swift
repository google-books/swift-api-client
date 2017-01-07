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
        sleep(2)
    }
    
}
