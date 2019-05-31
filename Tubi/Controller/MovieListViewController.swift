import UIKit

final class MovieListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var viewModel: MovieListViewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.searchBar.delegate = viewModel.self
        viewModel.getMovies()
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configureCell(movie: viewModel.filteredMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "movieDetailViewController") as? MovieDetailViewController else { return }
        let id = viewModel.filteredMovies[indexPath.row].id
        detailViewController.viewModel = MovieDetailViewModel(movieId: id)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //With this pattern you are shown 2 columns of movies. This does not change if the phone is turned horizontally
        let width = collectionView.bounds.size.width / 2
        let height = collectionView.bounds.size.height / 3
        return CGSize(width: width, height: height)
    }
}

extension MovieListViewController: ListViewModelDelegate {
    func loadMovies() {
        self.collectionView.reloadData()
    }
}
