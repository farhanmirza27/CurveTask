
struct Movie : Codable {
    var id : Int
    var title : String
    var voteAverage : Double?
    var releaseDate : String?
    var popularity : Double?
    var posterPath : String?
    
    func getPosterURL() -> String {
        guard let posterPath = self.posterPath else {return ""}
    return "https://image.tmdb.org/t/p/w500" + posterPath
    }
    
    func getVoteAverage() -> String {
        guard let voteAverage = voteAverage else {return ""}
        return String(format: "%.0f", (voteAverage/10) * 100) + "%"
    }
}
