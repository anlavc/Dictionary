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
    var searchWord: [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
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
        
    }
    private func configureHeaderView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FooterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: collectionCell)
    }
    }
extension CustomFooterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (searchWord?.prefix(5).count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as? FooterCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell()}
        cell.label.text = searchWord?[indexPath.row]
       // cell.setup(word: searchWord[indexPath.row])
        return cell
    }
    
}

extension CustomFooterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing + 20
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimensions = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimensions - 10, height: itemDimensions - 50)
    }
    
}
