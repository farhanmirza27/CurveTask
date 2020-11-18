

///Popular Movies use cases..
protocol PopularMoviesWorkerProtocol {
    func fetchPopularMovies(page : Int ,completion: @escaping (Result<PopularMovies,Error>) ->Void)
    func saveFavourite(movieId : Int)
}
 
/// Popular Movies worker class to hande all data handling requests/...
class  PopularMoviesWorker : PopularMoviesWorkerProtocol {
    var api: APIClientProtocol
    var localDataManager : LocalDataManagerProtocol
    
    required init(api : APIClientProtocol, localDataManager : LocalDataManagerProtocol) {
        self.api = api
        self.localDataManager = localDataManager
    }
    
    func fetchPopularMovies(page: Int, completion: @escaping (Result<PopularMovies, Error>) -> Void) {
        api.getMovies(page: page, completion: { result in
            completion(result)
        })
    }

    // mark a movie as favourite
    func saveFavourite(movieId: Int) {
        localDataManager.saveFavourite(movieId: movieId)
    }
}
