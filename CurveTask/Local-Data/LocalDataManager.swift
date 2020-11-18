

import Foundation

/// Local data manager use cases...
protocol LocalDataManagerProtocol {
    func saveFavourite(movieId : Int)
    func isFavouriteMovie(movieId : Int) -> Bool
    func getFavouriteMovieIds() -> [Int]
}

/// Local data manager class to handle local data functions..
class LocalDataManager : LocalDataManagerProtocol {
    let defaults = UserDefaults.standard
    
    func saveFavourite(movieId: Int) {
       var favouriteMovieIds = getFavouriteMovieIds()
        if favouriteMovieIds.contains(movieId) {
            guard let index = favouriteMovieIds.firstIndex(of: movieId) else {return}
            favouriteMovieIds.remove(at: index)
        }
        else {
            favouriteMovieIds.append(movieId)
        }
       saveFavouriteMovieIds(movieIds: favouriteMovieIds)
    }
    
    func isFavouriteMovie(movieId: Int) -> Bool {
        return getFavouriteMovieIds().contains(movieId)
    }
    
    func getFavouriteMovieIds() -> [Int] {
        return defaults.array(forKey: "FavouriteMovieIds")  as? [Int] ?? [Int]()
    }
    
    private func saveFavouriteMovieIds(movieIds : [Int]) {
        defaults.set(movieIds, forKey: "FavouriteMovieIds")
    }
}
