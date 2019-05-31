import Foundation

public protocol Requests {
    var url: URL { get }
}

private var baseUrl: String = "https://us-central1-modern-venture-600.cloudfunctions.net/api/movies"

//This might get confusing, an alternative is to have two request, one for movieList and one for detail
public struct movieRequest: Requests {
    public let url: URL
    
    public init?() {
        let urlString = baseUrl
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
    
    public init?(movieId: String) {
        let urlString = baseUrl + "/" + movieId
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
}

public struct movieImageRequest: Requests {
    public let url: URL
    
    public init?(imagePath: String) {
        let urlString = imagePath
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
}
