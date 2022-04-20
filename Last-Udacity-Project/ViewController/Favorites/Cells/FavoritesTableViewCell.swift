//
//  FavoritesTableViewCell.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 20.04.22.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteArticleTitle: UILabel!
    
    @IBOutlet weak var favoriteArticleSection: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
          
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
