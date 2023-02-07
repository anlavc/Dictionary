//
//  SearchDetailTableViewCell.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit

class SearchDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var meaningOneLabel: UILabel!
    @IBOutlet weak var meaninTwoLabel: UILabel!
    
    @IBOutlet weak var meaninThreeLabel: UILabel!
    @IBOutlet weak var sectionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
