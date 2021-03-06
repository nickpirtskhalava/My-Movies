//
//  MoviesCollectionPresenter.swift
//  Movies
//
//  Created by Nikoloz Phirtskhalava on 6/27/20.
//  Copyright © 2020 Nikoloz Phirtskhalava. All rights reserved.
//

import Foundation

protocol MoviesView: class {
    func reloadData()
    func showError(message: String)
}

protocol MoviesPresenter {
    var  numberOfMovies: Int { get }
    var  category: MovieCategory { get }
    func viewDidLoad()
    func didSelect(row: Int)
    func didTapFilter(cateogry: MovieCategory)
    func configure(cell: MovieCollectionCell, forRow row: Int)
}

class MoviesPresenterImpl: MoviesPresenter {
    
    fileprivate let useCase: DisplayMoviesUseCase
    fileprivate weak var view: MoviesView?
    fileprivate var router: MoviesRouter
    fileprivate var dataSource: [Movie] = []
    fileprivate var selectedCategory: MovieCategory = .popular
    
    var numberOfMovies: Int {
        return dataSource.count
    }
    
    var category: MovieCategory {
        return selectedCategory
    }
    
    init(view: MoviesView?,
         router: MoviesRouter,
         useCase: DisplayMoviesUseCase) {
        self.useCase = useCase
        self.router = router
        self.view = view
    }
    
    func viewDidLoad() {
        fetchMoviesBy(type: .popular)
    }
    
    func fetchMoviesBy(type: MovieCategory) {
        useCase.displayMovies(for: type) { [weak self] (result) in
            switch result {
            case let .success(movies):
                self?.dataSource = movies
                self?.view?.reloadData()
                break
            case let .failure(error):
                self?.view?.showError(message: error.localizedDescription)
                break
            }
        }
    }
}

// MARK: TableView Datasource Delegate Handling

extension MoviesPresenterImpl {
    
    func configure(cell: MovieCollectionCell, forRow row: Int) {
        let movie = dataSource[row]
        let model = movie.viewModel
        cell.configure(with: model)
    }
    
    func didSelect(row: Int) {
        let movie = dataSource[row]
        self.router.presentDetailsView(for: movie)
    }
}

// MARK: Filter

extension MoviesPresenterImpl {
    
    func didTapFilter(cateogry: MovieCategory) {
        selectedCategory = cateogry
        fetchMoviesBy(type: cateogry)
    }
}
