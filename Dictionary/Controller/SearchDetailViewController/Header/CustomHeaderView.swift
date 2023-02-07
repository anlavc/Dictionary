//
//  HeaderDetailView.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit


class CustomHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    private var collectionCell = "collectionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureHeaderView()
   
      
        
       
    }
    private func configureHeaderView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: collectionCell)
        soundButton.layer.shadowColor = UIColor.black.cgColor
        soundButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        soundButton.layer.masksToBounds = false
        soundButton.layer.shadowRadius = 2.0
        soundButton.layer.shadowOpacity = 0.5
        soundButton.layer.cornerRadius = soundButton.frame.width / 2
     
    
       
//        if let flowLayout = headerCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
    }
    @IBAction func soundButtonPressed(_ sender: UIButton) {
    }
    
}
extension CustomHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as? HeaderCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell()}
        cell.label.text = "Noun"
        
        return cell
    }

  
  
    
}
