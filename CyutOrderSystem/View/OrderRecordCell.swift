//
//  OrderDetailCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/18.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class OrderRecordCell: UITableViewCell {

    @IBOutlet weak var checkimage: UIImageView!
    @IBOutlet weak var orderNoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
