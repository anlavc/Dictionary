//
//  FooterCollectionViewCell.swift
//  Dictionary
//
//  Created by Anıl AVCI on 8.02.2023.
//

import UIKit

class FooterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view: UIView!
    private var synonymviewModel = SynonymListViewModel()
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
      
    }
//    func setup(word: SynonymResultModel) {
//        label.text = word.word
//    }
    
}
