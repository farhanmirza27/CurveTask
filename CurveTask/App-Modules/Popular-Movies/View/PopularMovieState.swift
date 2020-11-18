

/// Popular Movie state to display in cell..
struct PopularMovieState {
    var id : Int
    var title : String
    var posterUrl : String
    var releaseDate : String
    var voteAverage : String
    
    func isFavourite() -> Bool {
        return LocalDataManager().getFavouriteMovieIds().contains(id)
    }
}
