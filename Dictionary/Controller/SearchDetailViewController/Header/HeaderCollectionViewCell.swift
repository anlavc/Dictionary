//
//  HeaderCollectionViewCell.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        
    }

}
