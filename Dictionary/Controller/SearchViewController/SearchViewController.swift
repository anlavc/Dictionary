//
//  SearchViewController.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    private var cell = "searchCell"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
       
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.searchTextField.backgroundColor = UIColor.systemBackground
    }




    @IBAction func searchButtonPressed(_ sender: Any) {
        
    }
    
}
// MARK: - Table view data source
extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: cell, for:  indexPath) as! SearchTableViewCell
        cell.searchLabel.text = "Search 1"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
