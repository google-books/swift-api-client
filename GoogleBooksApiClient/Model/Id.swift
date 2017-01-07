import Foundation

public struct Id<T> {
    
    public let value: String
    public init(_ value: String) {
        self.value = value
    }
    
}

// MARK: - Equatable
extension Id: Equatable {}
public func ==<T>(lhs: Id<T>, rhs: Id<T>) -> Bool {
    return lhs.value == rhs.value
}

// MARK: - Hasable
extension Id: Hashable {
    
    public var hashValue: Int {
        return value.hashValue
    }
    
}
