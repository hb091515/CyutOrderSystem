//
//  SearchTableViewCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/11/26.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var mealimage: UIImageView!
    @IBOutlet weak var mealname: UILabel!
    @IBOutlet weak var mealcost: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
