//
//  MemberCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/11/11.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {

    @IBOutlet weak var type_icon: UIImageView!
    @IBOutlet weak var type_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
