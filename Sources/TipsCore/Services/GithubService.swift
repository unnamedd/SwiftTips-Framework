import Foundation

struct GithubService {
    typealias CompletionDetail = (ServiceResult<String>) -> Void
    
    static func markdown(from source: Tricks.Source, completion: @escaping CompletionDetail) {
        Service.requestText(source.markdownURL, completion: completion)
    }
}
