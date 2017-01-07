import Foundation

public protocol Entity {
    
    var id: Id<Self> { get }
    
}

extension Entity {
    
    public func hasSameIdentity(_ other: Self) -> Bool {
        return id.value == other.id.value
    }
    
}
