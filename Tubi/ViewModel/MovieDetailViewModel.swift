import Foundation

protocol DetailViewModelDelegate: class {
    func updateUI()
}

final class MovieDetailViewModel {
    private var tubiClient: TubiClient

    var movie: Movie?
    var movieId: String
    
    weak var delegate: DetailViewModelDelegate?
    
    init(movieId: String, tubiClient: TubiClient = TubiClient()) {
        self.movieId = movieId
        self.tubiClient = tubiClient
    }

    func getMovieDetails() {
        tubiClient.getMovieDetails(movieId: movieId) { [weak self] (result: Result<Movie>) in
            guard let `self` = self else { return }
            switch result {
            case .result(let movie):
                self.movie = movie
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
                cache.add(key: self.movieId, value: movie)
            case .error(let error):
                //Handle Error ie crashalytics, UIAlert, pop screen, etc using the delegate
                //Depending on how you handle the error you might want to stop the spinner........
                print(error)
            }
        }
    }
}
