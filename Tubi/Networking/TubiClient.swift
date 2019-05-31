import Foundation
import UIKit

public protocol TubiAPI {
    func getMoviesList(completion: @escaping (Result<[Movie]>) -> Void)
    func getMovieDetails(movieId: String, completion: @escaping (Result<Movie>) -> Void)
    func getMovieImage(imagePath: String, completion: @escaping (Result<UIImage?>) -> Void)
}

class TubiClient: TubiAPI {
    let service: NetworkService
    
    public init(netService: NetworkService? = nil) {
        self.service = netService ?? NetworkService()
    }
    
    func getMovieDetails(movieId: String, completion: @escaping (Result<Movie>) -> Void) {
        guard let request = movieRequest(movieId: movieId) else {
            DispatchQueue.global().async {
                completion(Result.error(ServiceError.requestError))
            }
            return
        }
        service.get(request: request) { (result: Result<Data>) in
            do {
                switch result {
                case .result(let data):
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    let movie = Movie(json: jsonData)
                    completion(Result.result(movie))
                case .error(let error):
                    completion(Result.error(error))
                }
            } catch {
                completion(Result.error(ServiceError.invalidData))
            }
        }
    }
    
    func getMoviesList(completion: @escaping (Result<[Movie]>) -> Void) {
        guard let request = movieRequest() else {
            DispatchQueue.global().async {
                completion(Result.error(ServiceError.requestError))
            }
            return
        }
        service.get(request: request) { (result: Result<Data>) in
            do {
                switch result {
                case .result(let data):
                    print(data)
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [NSDictionary]
                    let movies = jsonData.map { Movie(json: $0) }
                    completion(Result.result(movies))
                case .error(let error):
                    completion(Result.error(error))
                }
            } catch {
                completion(Result.error(ServiceError.invalidData))
            }
        }
    }
    
    func getMovieImage(imagePath: String, completion: @escaping (Result<UIImage?>) -> Void) {
        guard let request = movieImageRequest(imagePath: imagePath) else {
            DispatchQueue.global().async {
                completion(Result.error(ServiceError.requestError))
            }
            return
        }
        service.get(request: request) { (result: Result<Data>) in
            switch result {
            case .result(let data):
                let image = UIImage(data: data)!
                completion(Result.result(image))
            case .error(let error):
                completion(Result.error(error))
            }
        }
    }
}
