//
//  MovieCell.swift
//
//
//  Created by administrator on 11/9/18.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var overLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

