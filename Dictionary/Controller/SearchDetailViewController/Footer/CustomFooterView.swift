//
//  CustomFooterView.swift
//  Dictionary
//
//  Created by Anıl AVCI on 8.02.2023.
//

import UIKit

class CustomFooterView: UITableViewHeaderFooterView {
 
    private var collectionCell = "footerCell"
    @IBOutlet weak var collectionView: UICollectionView!
    private var synonymviewModel = SynonymListViewModel()
    var searchWord: String?
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureHeaderView()
        loadSynonymResult()
        print("Gelen word func: \(searchWord ?? "yok")")
      
    }

    private func configureHeaderView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FooterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: collectionCell)
    }

    func loadSynonymResult() {
        
        self.synonymviewModel.fetchSearchResult(searchWord ?? "") { result in
            switch result {
            case .success(_ ):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.collectionView.reloadData()
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
    

extension CustomFooterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return synonymviewModel.synonyms.prefix(5).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as? FooterCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell()}
        cell.setup(word: synonymviewModel.synonyms[indexPath.row])
      
        return cell
    }
    
}

extension CustomFooterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimensions = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimensions, height: itemDimensions - 80)
    }
    
}
