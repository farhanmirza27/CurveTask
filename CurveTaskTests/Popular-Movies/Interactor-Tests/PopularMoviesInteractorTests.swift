//
//  PopularMoviesInteractorTests.swift
//  
//
//  Created by Farhan Mirza on 18/11/2020.
//

import XCTest
@testable import  CurveTask

class PopularMoviesInteractorTests: XCTestCase {
    
    var sut : PopularMoviesInteractor?
    var mockedWorker : MockedWorker?
    var mockedPresenter : MockedPresenter?
    
    override func setUp() {
        mockedWorker = MockedWorker()
        mockedPresenter = MockedPresenter()
        sut = PopularMoviesInteractor(worker: mockedWorker!)
        sut?.presenter = mockedPresenter
    }
    
    override func tearDown() {
        sut = nil
        mockedWorker = nil
        mockedPresenter = nil
    }
    
    
    func testFetchMoviesSucess() {
        mockedWorker?.dataReturnedFromAPI = true
        sut?.fetchMovies()
        XCTAssertTrue(mockedPresenter!.moviesDidFetched)
    }
    
    func testFetchMoviesFailure() {
        mockedWorker?.dataReturnedFromAPI = false
        sut?.fetchMovies()
        XCTAssertFalse(mockedPresenter!.moviesDidFetched)
    }
    
    func testMarkAsFavourite() {
        sut?.markAsFavourite(movieId: 1)
        XCTAssertTrue(mockedWorker!.saveFavouriteCalled)
    }
}

/// Mocked Worker...
class MockedWorker : PopularMoviesWorkerProtocol {
    var dataReturnedFromAPI = false
    var saveFavouriteCalled = false
    var isFavouriteMovieCalled = false
    func fetchPopularMovies(page: Int, completion: @escaping (Result<PopularMovies, Error>) -> Void) {
        if dataReturnedFromAPI {
            completion(.success(mockedWorkerResponse))
        }
        else {
            completion(.failure(NSError(domain: "API Error", code: 1, userInfo: nil)))
        }
    }
    
    func saveFavourite(movieId: Int) {
        saveFavouriteCalled = true
    }
    
    func isFavouriteMovie(movieId: Int) -> Bool {
        isFavouriteMovieCalled = true
        return true
    }
}

/// Mocked  Presenter..
class MockedPresenter : PopularMoviesPresenterProtocol {
    var moviesDidFetched = false
    func movieForRow(index: Int) -> PopularMovieState? {
        return nil
    }
    
    func numberOfRows() -> Int {
        return 0
    }
    
    func didFetch(didFetch popularMovies: [Movie]) {
        if popularMovies.count == mockedWorkerResponse.results.count {
            moviesDidFetched = true
        }
    }
    
    func failure(message: String) {
        moviesDidFetched = false
    }
}

/// mocked API response...
fileprivate let mockedWorkerResponse = PopularMovies(page: 1, totalResults: 2, totalPages: 20, results: [
    Movie(id: 1, title: "Movie 1", voteAverage: 6.3, releaseDate: "2020-10-30", popularity: nil, posterPath: "fakepath1/w500"),
    Movie(id: 2, title: "Movie 2", voteAverage: 3.3, releaseDate: "2020-4-10", popularity: nil, posterPath: "fakepath2/w500")
])

