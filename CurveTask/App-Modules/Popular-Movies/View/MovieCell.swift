

import UIKit

/// Table View Popular Movie List Cell
class MovieCell : TableViewBaseCell {
    
    var posterImage = UIComponents.shared.imageView(imageName: "", contentMode: .scaleAspectFit, clipsToBounds : true)
    var titleLabel  = UIComponents.shared.label(text: "", textStyle: .headline, color: .black)
    var votingAverageLabel = UIComponents.shared.label(text: "", textStyle: .body, color: .black)
    var releaseDateLabel = UIComponents.shared.label(text: "", textStyle: .body, color: .black)
    var favButton = UIComponents.shared.buttonWithImage(imageName: "notFav",tintColor: UIColor.systemYellow)
    
    weak var view : PopularMoviesViewController?
    
    // set movie properties
    var movieStateView : PopularMovieState? {
        didSet {
            guard let movieStateView = movieStateView else {return}
            titleLabel.text = movieStateView.title
            posterImage.cacheImage(imageUrl : movieStateView.posterUrl)
            releaseDateLabel.text = movieStateView.releaseDate
            votingAverageLabel.text = movieStateView.voteAverage
            if movieStateView.isFavourite() {
                markAsFavourite()
            } else {
                markAsNotFavourite()
            }
        }
    }
    
    // setup UI components
    override func setupUI() {
        contentView.addSubViews(views: posterImage,titleLabel,votingAverageLabel,releaseDateLabel,favButton)
        favButton.addTarget(self, action: #selector(didClickFav), for: .touchUpInside)
        setupConstraints()
    }
    
    /// setup Constraints..
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            posterImage.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: posterImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: favButton.leadingAnchor,constant: -16),
            
            votingAverageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            votingAverageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 4),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor),
            
            favButton.heightAnchor.constraint(equalToConstant: 25),
            favButton.widthAnchor.constraint(equalToConstant: 25),
            favButton.topAnchor.constraint(equalTo: posterImage.topAnchor),
            favButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16)
        ])
    }
}


//MARK: Handling Favourite / Not Favourite
extension MovieCell {
    @objc func didClickFav() {
        if favButton.currentImage == UIImage(named: "isFav") {
            markAsNotFavourite()
        }
        else {
            markAsFavourite()
        }
        guard let movieId = self.movieStateView?.id else {return}
        view?.interactor?.markAsFavourite(movieId: movieId)
    }
    
    private func markAsFavourite() {
        favButton.setImage(UIImage(named: "isFav"), for: .normal)
    }
    private func markAsNotFavourite() {
        favButton.setImage(UIImage(named: "notFav"), for: .normal)
    }
}
