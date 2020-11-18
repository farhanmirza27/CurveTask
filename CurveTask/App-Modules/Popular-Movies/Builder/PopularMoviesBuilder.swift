

import UIKit

/// Popular Movies builder class with all dependies configuration..
class  PopularMoviesBuilder {
    class func buidModule() -> PopularMoviesViewController {
        let view = PopularMoviesViewController()
        
        let popularMoviesWorker = PopularMoviesWorker(api:  APIClient(), localDataManager: LocalDataManager())
        let interactor = PopularMoviesInteractor(worker: popularMoviesWorker)
        let presenter = PopularMoviesPresenter()
        
        interactor.presenter = presenter
        view.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
