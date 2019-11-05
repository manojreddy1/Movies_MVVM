//
//  ViewController.swift
//  Movies
//
//  Created by Vaayoo on 02/07/19.
//  Copyright © 2019 Vaayoo. All rights reserved.
//
typealias delegate = UITableViewDelegate & UITableViewDataSource
let cellIdentifier = "reuseIdentifier"
import UIKit
import Alamofire

class ViewController: UIViewController,delegate, UISearchControllerDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var tbl_movies: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel = MoviesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies"
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textField.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 15;
                backgroundview.clipsToBounds = true;
            }
        }
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        tbl_movies.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        viewModel.fetchMovie(endPoint: "http://www.omdbapi.com/?apikey=fc4c7d83&t=Horror&plot=full") {
            DispatchQueue.main.async {
                self.tbl_movies.reloadData()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(rows: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl_movies.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel!.text = viewModel.titleForRowAtIndexPath(indexPath: indexPath)
        return cell
    }

}
extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text!.count > 1{
            viewModel.fetchMovie(endPoint: "http://www.omdbapi.com/?apikey=fc4c7d83&t=\(searchController.searchBar.text!)&plot=full") {
                DispatchQueue.main.async {
                    self.tbl_movies.reloadData()
                }
            }
        }
    }
}
