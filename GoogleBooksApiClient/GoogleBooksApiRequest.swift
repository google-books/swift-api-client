import Foundation

private let BASE_URL: URL = URL(string: "https://www.googleapis.com/books/v1")!

public protocol GoogleBooksApiRequest {
    
    associatedtype Result
    
}

protocol GoogleBooksApiRequestType {

    var method: HttpMethod { get }
    var path: String { get }
    var url: URL { get }
    var params: [RequestParameter] { get }
    var headers: [RequestHeader] { get }
    var authInfo: GoogleBooksApiAuthInfo? { get }
    
}

extension GoogleBooksApiRequestType {
    
    var url: URL {
        return BASE_URL.appendingPathComponent(path)
    }
    
    var params: [RequestParameter] {
        return []
    }
    
    var headers: [RequestHeader] {
        return []
    }
    
}

public struct GoogleBooksApi {

    // MARK: - Bookshelf
    public struct BookshelfRequest {
        
        /// GET /users/{user_id}/bookshelves/{bookshelf_id}
        /// Retrieves a specific Bookshelf resource for the specified user.
        public struct Get: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bookshelf
            private let id: BookshelfId
            private let userId: String
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(id: BookshelfId, userId: String, authInfo: GoogleBooksApiAuthInfo? = nil) {
                self.id = id
                self.userId = userId
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/users/%@/bookshelves/%@", userId, id.rawValue)
            }
            
        }
        
        /// GET /users/{user_id}/bookshelves
        /// Retrieves a list of public Bookshelf resource for the specified user.
        public struct List: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bookshelves
            private let userId: String
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(userId: String, authInfo: GoogleBooksApiAuthInfo? = nil) {
                self.userId = userId
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/users/%@/bookshelves", userId)
            }
            
        }

    }

    // MARK: - Volume
    public struct VolumeRequest {
        
        /// GET /volumes/{volume_id}
        /// Retrieves a Volume resource based on ID.
        public struct Get: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Volume
            private let id: Id<Volume>
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(id: Id<Volume>, authInfo: GoogleBooksApiAuthInfo? = nil) {
                self.id = id
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/volumes/%@", id.value)
            }
            
        }
        
        /// GET /volumes?q={search_terms}
        /// Performs a book search.
        public struct List: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Volumes
            private let query: String
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(query: String, authInfo: GoogleBooksApiAuthInfo? = nil) {
                self.query = query
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return "/volumes"
            }
            
            var params: [RequestParameter] {
                return [("q", query)]
            }
            
        }
        
    }
    
    // MARK: - Bookshelves.Volumes
    public struct BookshelvesVolumesRequest {
        
        /// GET  /users/{userId}/bookshelves/{shelf}/volumes
        /// Retrieves volumes in a specific bookshelf for the specified user.
        public struct List: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Volumes
            private let userId: String
            private let shelf: BookshelfId
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(userId: String, shelf: BookshelfId, authInfo: GoogleBooksApiAuthInfo? = nil) {
                self.userId = userId
                self.shelf = shelf
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/users/%@/bookshelves/%@/volumes", userId, shelf.rawValue)
            }
            
        }
        
    }
    
    // MARK: - MyLibrary.Bookshelves
    public struct MyLibraryBookshelvesRequest {
        
        /// POST  /mylibrary/bookshelves/{shelf}/addVolume
        /// Adds a volume to a bookshelf.
        public struct AddVolume: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bool
            private let shelf: BookshelfId
            private let volumeId: Id<Volume>
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(shelf: BookshelfId, volumeId: Id<Volume>, authInfo: GoogleBooksApiAuthInfo) {
                self.shelf = shelf
                self.volumeId = volumeId
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .post
            }
            
            var path: String {
                return String(format: "/mylibrary/bookshelves/%@/addVolume", shelf.rawValue)
            }
            
            var params: [RequestParameter] {
                return [("volumeId", volumeId.value)]
            }
            
        }
        
        /// POST  /mylibrary/bookshelves/{shelf}/clearVolumes
        /// Clears all volumes from a bookshelf.
        public struct ClearVolumes: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bool
            private let shelf: BookshelfId
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(shelf: BookshelfId, authInfo: GoogleBooksApiAuthInfo) {
                self.shelf = shelf
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .post
            }
            
            var path: String {
                return String(format: "/mylibrary/bookshelves/%@/clearVolumes", shelf.rawValue)
            }
            
        }
        
        /// GET  /mylibrary/bookshelves/{shelf}
        /// Retrieves metadata for a specific bookshelf belonging to the authenticated user.
        public struct Get: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bookshelf
            private let shelf: BookshelfId
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(shelf: BookshelfId, authInfo: GoogleBooksApiAuthInfo) {
                self.shelf = shelf
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/mylibrary/bookshelves/%@", shelf.rawValue)
            }
            
        }
        
        /// GET  /mylibrary/bookshelves
        /// Retrieves a list of bookshelves belonging to the authenticated user.
        public struct List: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bookshelves
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(authInfo: GoogleBooksApiAuthInfo) {
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return "/mylibrary/bookshelves"
            }
            
        }
        
        /// POST  /mylibrary/bookshelves/shelf/moveVolume
        /// Moves a volume within a bookshelf.
        public struct MoveVolume: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bool
            private let shelf: BookshelfId
            private let volumeId: Id<Volume>
            private let volumePosition: Int
            let authInfo: GoogleBooksApiAuthInfo?
            
            public init(shelf: BookshelfId, volumeId: Id<Volume>, volumePosition: Int, authInfo: GoogleBooksApiAuthInfo) {
                self.shelf = shelf
                self.volumeId = volumeId
                self.volumePosition = volumePosition
                self.authInfo = authInfo
            }
            
            var method: HttpMethod {
                return .post
            }
            
            var path: String {
                return String(format: "/mylibrary/bookshelves/%@/moveVolume", shelf.rawValue)
            }
            
            var params: [RequestParameter] {
                return [
                    ("volumeId", volumeId.value),
                    ("volumePosition", String(volumePosition))
                ]
            }
            
        }
        
    }
    
}
