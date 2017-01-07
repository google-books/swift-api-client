import Foundation

public protocol Kind {
    
    var rawValue: String {
        get
    }
    
}

public enum BooksKind: String, ValueObject, Kind, CustomStringConvertible {
    
    case volume = "volume"
    case volumes = "volumes"
    case bookshelf = "bookshelf"
    case downloadAccessRestriction = "downloadAccessRestriction"
    
    public var description: String {
        return "books#" + rawValue
    }
    
}
