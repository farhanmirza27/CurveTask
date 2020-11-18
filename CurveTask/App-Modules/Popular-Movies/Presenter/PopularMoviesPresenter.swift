

/// Popular Movies Presenter use cases...
protocol PopularMoviesPresenterProtocol : class {
    func movieForRow(index : Int) -> PopularMovieState?
    func numberOfRows() -> Int
    func didFetch(didFetch popularMovies: [Movie])
    func failure(message : String)
}

/// Popular Movies Presenter class
class PopularMoviesPresenter  : PopularMoviesPresenterProtocol {
    
    weak var view : PopularMoviesViewProtocol?
     var popularMovies : [Movie]?
    
    func numberOfRows() -> Int {
        return popularMovies?.count ?? 0
    }
    
    func movieForRow(index : Int) -> PopularMovieState? {
        guard let movie = popularMovies?[index] else {return nil}
        return PopularMovieState(id: movie.id, title: movie.title, posterUrl: movie.getPosterURL(), releaseDate: movie.releaseDate ?? "", voteAverage: movie.getVoteAverage())
    }
    
    /// update view of success
    func didFetch(didFetch popularMovies: [Movie]) {
        self.popularMovies = popularMovies
        view?.showMovies()
    }
    
    /// update view for failure case...
    func failure(message: String) {
        view?.failure(message: message)
    }
}
