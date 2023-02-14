//
//  SearchDetailViewController.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private var cell = "detailCell"
    private var headercell = "CustomHeaderView"
    private var footercell = "CustomFooterView"
    @IBOutlet weak var detailTableView: UITableView!
    private var detailviewModel = DetailListViewModel()
    var searchText: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableRegisterandDelegate()
        loadSearchResult()
        print("\(ApiConstrants.searchUrl)\(searchText!)")
        detailTableView.sectionHeaderTopPadding = 0
    
      
    }
    private func tableRegisterandDelegate() {
        spinner.transform = CGAffineTransform(scaleX: 3, y: 3)
        detailTableView.register(UINib(nibName: "SearchDetailTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
        detailTableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: headercell)
        detailTableView.register(UINib(nibName: "CustomFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: footercell)
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }

    func loadSearchResult() {
        spinner.startAnimating()
        self.detailviewModel.fetchSearchResult(self.searchText ?? "") { result in
            switch result {
            case .success(_ ):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.detailTableView.reloadData()
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                }
            case .failure(_ ):
                DispatchQueue.main.async { [weak self] in
                    guard self != nil else { return }
                    print("hata var")
                    // aranan sonuç gelmediyse 2 saniye bekle ve homevc geri dön indicator animasyonunu durdur ve gizle.
                    sleep(2)
                    self?.spinner.stopAnimating()
                    self?.spinner.isHidden = true
                    self?.navigationController?.popViewController(animated: true)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

}
extension SearchDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {

        if detailviewModel.meanings.count == 0 {
        detailTableView.setEmptyView(title: "Invalid Value", message: "No results were found for the search term.")
        }
        else {
        detailTableView.restore()
        }
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
        footerView?.searchWord = searchText
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

