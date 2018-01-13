import Foundation

struct GithubService {
    typealias CompletionDetail = (ServiceResult<String>) -> Void
    
    static func markdown(completion: @escaping CompletionDetail) {
        let url = "https://raw.githubusercontent.com/JohnSundell/SwiftTips/master/README.md"
        Service.requestText(url, completion: completion)
    }
}
