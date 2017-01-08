import Foundation

public protocol Entity {
    
    associatedtype ID: Equatable
    
    var id: ID { get }
    
}

extension Entity {
    
    public func hasSameIdentity(_ other: Self) -> Bool {
        return id == other.id
    }
    
}
