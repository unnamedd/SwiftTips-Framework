import Foundation

struct Comment {
    var text: String?
    
    init?(_ value: String?) {
        guard value != nil, value != "" else {
            return nil
        }
        
        text = value
    }
}

extension Comment: CustomStringConvertible {
    var description: String {
        return text ?? "Comment(nil)"
    }
}
