

struct PopularMovies : Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results : [Movie]
}

