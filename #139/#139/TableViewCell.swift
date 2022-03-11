//
//  TableViewCell.swift
//  #139
//
//  Created by Lan Ran on 2022/3/9.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageViews: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
