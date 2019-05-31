import Foundation
import UIKit

protocol ListViewModelDelegate: class {
    func loadMovies()
}

final class MovieListViewModel: NSObject {
    fileprivate var tubiClient: TubiClient = TubiClient()
    
    weak var delegate: ListViewModelDelegate?
    
    var movies = [Movie]()
    var filteredMovies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.loadMovies()
            }
        }
    }
    
    func getMovies() {
        tubiClient.getMoviesList { [weak self] (result: Result<[Movie]>) in
            guard let `self` = self else { return }

            switch result {
            case .result(let movies):
                self.movies = movies
                self.filteredMovies = movies
            case .error(let error):
                //Handel error crashalytics, alert etc
                print(error)
            }
        }
    }
}

extension MovieListViewModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = searchText.isEmptyOrWhiteSpace ? movies : movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
}

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}
