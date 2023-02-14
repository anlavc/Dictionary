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
    private var footercell = "CustomFooterView"
    @IBOutlet weak var detailTableView: UITableView!
    private var detailviewModel = DetailListViewModel()
    var searchText: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.register(UINib(nibName: "SearchDetailTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
        detailTableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: headercell)
        detailTableView.register(UINib(nibName: "CustomFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: footercell)
        detailTableView.dataSource = self
        detailTableView.delegate = self
        loadSearchResult()
        print("\(ApiConstrants.searchUrl)\(searchText!)")
        detailTableView.sectionHeaderTopPadding = 0
     
      
    }
    func wordFunc() -> String {
        return searchText
    }
    func loadSearchResult() {
        self.detailviewModel.fetchSearchResult(self.searchText ?? "") { result in
            switch result {
            case .success(_ ):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.detailTableView.reloadData()
                }
            case .failure(_ ):
                DispatchQueue.main.async { [weak self] in
                    guard self != nil else { return }
                    print("hata var")
                }
            }
        }
    }

}
extension SearchDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailviewModel.meanings.count
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return detailviewModel.meanings[section].definitions.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = detailTableView.dequeueReusableCell(withIdentifier: cell, for:  indexPath) as! SearchDetailTableViewCell
        cell.numberLabel.text = "\(indexPath.row + 1)-"
        cell.sectionTitle.text = detailviewModel.meanings[indexPath.section].partOfSpeech
        cell.meaningOneLabel.text = detailviewModel.meanings[indexPath.section].definitions[indexPath.row].definition
       
        if let examplesTitle = detailviewModel.meanings[indexPath.section].definitions[indexPath.row].example {
            cell.meaninTwoLabel.text = "Example"
            cell.meaninThreeLabel.text = examplesTitle
            cell.meaninTwoLabel.isHidden = false
            cell.meaninThreeLabel.isHidden = false
        }
    
        
        return cell
        
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = detailTableView.dequeueReusableHeaderFooterView(withIdentifier: headercell) as? CustomHeaderView
            headerView?.titleLabel.text = detailviewModel.cellForRowAt(0).word
            headerView?.detailLabel.text = detailviewModel.cellForRowAt(0).phonetic
//            headerView?.counts = detailviewModel.cellForRowAt(section).word.count
            return headerView
        } else {
            return nil
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(screenHeight * 0.17)
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = detailTableView.dequeueReusableHeaderFooterView(withIdentifier: footercell) as? CustomFooterView
        return footerView
    }
   
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == detailviewModel.meanings.count - 1 {
            return CGFloat(screenHeight * 0.15)
        } else {
            return CGFloat(0)
        }
    }
}

