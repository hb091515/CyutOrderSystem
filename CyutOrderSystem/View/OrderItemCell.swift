//
//  OrderItemCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/18.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class OrderItemCell: UITableViewCell {

    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealquantity: UILabel!
    @IBOutlet weak var mealpriceLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var mealimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
