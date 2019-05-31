import Foundation
import UIKit

public enum Result<ResultType> {
    case result(ResultType)
    case error(Error)
}

public enum ServiceError: Error {
    case invalidData
    case unknownResponse
    case requestError
}

public protocol Service {
    func get(request: Requests, completion: @escaping (Result<Data>) -> Void)
}

public final class NetworkService: Service {
    public func get(request: Requests, completion: @escaping (Result<Data>) -> Void) {
        URLSession.shared.dataTask(with: request.url) { (data, response, error) in
            if let error = error {
                completion(Result.error(error))
                return
            }
            if let resp = response as? HTTPURLResponse {
                let statusCode = resp.statusCode
                //300 Redirection messages
                //400 Client error responses
                //500 Server error responses
                if  statusCode >= 300 {
                    completion(Result.error(ServiceError.requestError))
                    return
                }
            }
            guard let data = data  else {
                completion(Result.error(ServiceError.invalidData))
                return
            }
            completion(.result(data))
            }.resume()
    }
}
