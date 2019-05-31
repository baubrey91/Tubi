import Foundation
import UIKit

let cache = TubiCache<String, Movie>(capacity: 5)

final class MovieDetailViewController: UIViewController, DetailViewModelDelegate {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: MovieImage!
    @IBOutlet weak var movieIndex: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .tubi
        self.viewModel.delegate = self
        //I believe you can use your isValid function here but I prefer just using optionals
        if let movie = cache.get(key: self.viewModel.movieId) {
            viewModel.movie = movie
            self.updateUI()
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //You don't want to make the network call on viewWillAppear as that will postpone loading the view
        if viewModel.movie == nil {
            viewModel.getMovieDetails()
        }
    }
    
    func updateUI() {
        activityIndicator.stopAnimating()
        guard let movie = viewModel.movie else { return }
        self.movieTitle.text = movie.titleLabel
        self.movieIndex.text = movie.indexLabel
        self.movieImage.imageFromServerURL(imagePath: movie.imagePath)
    }
}

fileprivate extension String {
    //You can localize your strings here if international
    static let tubi = "TubiTV"
}
