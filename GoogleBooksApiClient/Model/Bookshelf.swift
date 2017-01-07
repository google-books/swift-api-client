import Foundation

/// Represents Bookshelf resource
/// https://developers.google.com/books/docs/v1/reference/bookshelves#resource
public struct Bookshelf: Entity {
    
    public let kind: BooksKind = BooksKind.bookshelf
    public let id: Id<Bookshelf>
    public let selfLink: URL
    public let title: String
    public let desc: String?
    public let access: Access
    public let updated: String
    public let created: String
    public let volumeCount: Int
    public let volumesLastUpdated: String?
    
    public enum Access: String, ValueObject {
        
        case `public` = "PUBLIC"
        case `private` = "PRIVATE"
    }
    
}

// MARK: - Equatable
extension Bookshelf: Equatable {}
public func ==(lhs: Bookshelf, rhs: Bookshelf) -> Bool {
    return lhs.kind == rhs.kind
        && lhs.id == rhs.id
        && lhs.selfLink == rhs.selfLink
        && lhs.title == rhs.title
        && lhs.desc == rhs.desc
        && lhs.access == rhs.access
        && lhs.updated == rhs.updated
        && lhs.created == rhs.created
        && lhs.volumeCount == rhs.volumeCount
        && lhs.volumesLastUpdated == rhs.volumesLastUpdated
}
