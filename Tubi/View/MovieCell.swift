import Foundation
import UIKit

final class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImage: MovieImage!
    
    func configureCell(movie: Movie) {
        self.movieImage.image = nil
        self.titleLabel.text = movie.title
        //Placeholder Image, also needed for cell re-use
        self.movieImage.image = UIImage(named: "TubiImage")
        self.movieImage.imageFromServerURL(imagePath: movie.imagePath)
    }
}

final class MovieImage: UIImageView {
    private var imagePath: String?
    private var tubiClient: TubiClient = TubiClient()
    
    public func imageFromServerURL(imagePath: String) {
        self.imagePath = imagePath
        
        tubiClient.getMovieImage(imagePath: imagePath) { result in
            switch result {
            case .result(let image):
                if self.imagePath == imagePath {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
