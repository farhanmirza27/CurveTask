//
//  PopularMoviesPresenterTests.swift
//  CurveTaskTests
//
//  Created by Farhan Mirza on 18/11/2020.
//

import XCTest
@testable import CurveTask

/// Popular movies presenter tests...
class PopularMoviesPresenterTests: XCTestCase {
    
    var sut : PopularMoviesPresenter?
    var mockedView : MockedView?
    
    override func setUp() {
        sut = PopularMoviesPresenter()
        sut?.popularMovies = [Movie(id: 1, title: "Movie 1", voteAverage: 2.3, releaseDate: "2020-10-12", popularity: nil, posterPath: "fakePath1/")]
        
        mockedView = MockedView()
        sut?.view = mockedView
        mockedView?.presenter = sut
    }
    
    override func tearDown() {
        sut = nil
        mockedView = nil
    }
    
    
    func testDidFetch() {
        sut?.didFetch(didFetch: [])
        XCTAssertTrue(mockedView!.showMoviesCalled)
    }
    
    func testFailure() {
        sut?.failure(message: "failed..")
        XCTAssertFalse(mockedView!.showMoviesCalled)
    }
    
    func testMovieForRow() {
        let movieState = sut?.movieForRow(index: 0)
        XCTAssertEqual(movieState!.id, 1)
    }
    
    class MockedView : PopularMoviesViewProtocol {
        
        var presenter : PopularMoviesPresenterProtocol?
        var interactor : PopularMoviesInteractorProtocol?
        
        var showMoviesCalled = false
        func showMovies() {
            showMoviesCalled = true
        }
        
        func failure(message: String) {
            showMoviesCalled = false
        }
    }
}
