import Foundation

public struct Comment {
    public var text: String?
    
    init?(_ value: String?) {
        guard value != nil, value != "" else {
            return nil
        }
        
        text = value
    }
}

extension Comment: CustomStringConvertible {
    public var description: String {
        return text ?? "Comment(nil)"
    }
}
