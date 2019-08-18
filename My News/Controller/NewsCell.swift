//
//  NewsCell.swift
//  My News
//
//  Created by Amin faruq on 17/08/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
