
/// PopularMovies Interactor use cases..
protocol PopularMoviesInteractorProtocol : class {
    func fetchMovies()
    func markAsFavourite(movieId : Int)
}

/// PopularMovies Interactor
class PopularMoviesInteractor : PopularMoviesInteractorProtocol {
    var presenter : PopularMoviesPresenterProtocol?
    var worker: PopularMoviesWorkerProtocol
    var page = 1
    var popularMovies = [Movie]()
    
    /// dependency
    required init(worker : PopularMoviesWorkerProtocol) {
        self.worker = worker
    }
    
    // fetch movies
    func fetchMovies() {
        worker.fetchPopularMovies(page: page) { result in
            switch result {
            case .success(let popularMovies):
                self.page = self.page + 1
                self.popularMovies.append(contentsOf: popularMovies.results)
                self.presenter?.didFetch(didFetch: self.popularMovies)
            case .failure(let error):
                self.presenter?.failure(message: error.localizedDescription)
            }
        }
    }
    
    // mark movie as favorite
    func markAsFavourite(movieId: Int) {
        worker.saveFavourite(movieId: movieId)
    }
}










