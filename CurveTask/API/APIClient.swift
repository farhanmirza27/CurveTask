

import Foundation

/// APIClient use cases...
protocol APIClientProtocol {
    func getMovies(page: Int,completion : @escaping (Result<PopularMovies,Error>) -> Void)
}

/// APIClient to handle network requests...
class APIClient : APIClientProtocol {
    let session =  URLSession.shared
    
    func getMovies(page : Int,completion: @escaping (Result<PopularMovies, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=\(page)") else {return}
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                do {
                    if let data = data {
                        let decoder = JSONDecoder()
                        /// decoding strategy defined here as "convertFromSnakeCase"
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let contacts = try decoder.decode(PopularMovies.self, from: data)
                        completion(.success(contacts))
                    }
                }
                catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
