import Foundation
import TipsCore

let content = Tricks(from: .remote)
content.read { tips in
    tips.forEach { tip in
        guard
            let issue = tip.issue,
            let title = tip.title else {
            return
        }

        print("[\(issue)] \(title)")
        if let comments = tip.comments, comments.count > 0 {
            comments.forEach { comment in
                print("     - \(comment)")
            }
        }
    }
}


