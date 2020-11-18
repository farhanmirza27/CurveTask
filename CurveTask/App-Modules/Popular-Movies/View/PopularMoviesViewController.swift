

import UIKit

fileprivate let reuseIdentifier = "MovieCellId"

/// Popular movies View use cases..
protocol PopularMoviesViewProtocol : class {
    func showMovies()
    func failure(message : String)
}

// Popular Movies View
class PopularMoviesViewController : UITableViewController {
    
    var interactor : PopularMoviesInteractorProtocol?
    var presenter  : PopularMoviesPresenter?

    // bottom loading spinner..
    let bottomSpinner = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // fetch movies..
        startAnimating()
        interactor?.fetchMovies()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        bottomSpinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        navigationItem.title = "Popular Movies"
        
        // Config Table View
        tableView.register(MovieCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }
}

//MARK: UITableViewDelegate &  UITableViewDataSource
extension PopularMoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.view = self
        cell.movieStateView =  presenter?.movieForRow(index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 5 {
            // load more movies
            interactor?.fetchMovies()
            bottomSpinner.startAnimating()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return bottomSpinner
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}


//MARK: PopularMoviesViewProtocol
/// show movies list on view
extension PopularMoviesViewController : PopularMoviesViewProtocol {
    
    func showMovies() {
        DispatchQueue.main.async {
            self.stopAnimating()
            self.bottomSpinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.bottomSpinner.stopAnimating()
        self.alert(message: message)
    }
}
