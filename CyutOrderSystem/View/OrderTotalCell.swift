//
//  OrderTotalCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/18.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class OrderTotalCell: UITableViewCell {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
