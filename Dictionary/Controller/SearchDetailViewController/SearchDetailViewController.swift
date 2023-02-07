//
//  SearchDetailViewController.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit

class SearchDetailViewController: UIViewController {
  private var cell = "detailCell"
    private var headercell = "CustomHeaderView"

    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.register(UINib(nibName: "SearchDetailTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
        detailTableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: headercell)
        detailTableView.dataSource = self
        detailTableView.delegate = self
        
    }
    

}
extension SearchDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: cell, for:  indexPath) as! SearchDetailTableViewCell
        cell.numberLabel.text = "1-"
        cell.sectionTitle.text = "Noun"
        cell.meaningOneLabel.text = "One’s native land; the place or country in which one dwells; the place where one’s ancestors dwell or dwelt."
        cell.meaninTwoLabel.text = "Example"
        cell.meaninThreeLabel.text = "The missile was able to home in on the target."
        return cell
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = detailTableView.dequeueReusableHeaderFooterView(withIdentifier: headercell) as? CustomHeaderView
        headerView?.titleLabel.text = "Home"
        headerView?.detailLabel.text = "/home/"
        
        
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
}
