//
//  SearchViewController.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTableView: UITableView!
    private var cell = "searchCell"
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
       
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchView.layer.shadowColor = UIColor.gray.cgColor
        searchView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        searchView.layer.masksToBounds = false
        searchView.layer.shadowRadius = 1.0
        searchView.layer.shadowOpacity = 0.5
        searchView.layer.cornerRadius = 10
       
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !searchTextField.text.isNilOrEmpty {
            if segue.identifier == "searchtoDetail" {

                let gidilecekVC = segue.destination as! SearchDetailViewController
                
                gidilecekVC.searchText = searchTextField.text!

            } else {
                
                print("boş alan var")
            }
        }
   
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
