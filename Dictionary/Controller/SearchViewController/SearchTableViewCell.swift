//
//  SearchTableViewCell.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchButton: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
