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
        _ = client.getVolume(
            id: Id("EFXMMgEACAAJ"),
            onSuccess: { volume in
                NSLog("\(volume)")
            },
            onError: { error in
                NSLog("\(error)")
            }
        )
        sleep(1)
    }
    
}
