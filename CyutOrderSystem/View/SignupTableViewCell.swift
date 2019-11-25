//
//  SignupTableViewCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/11/24.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class SignupTableViewCell: UITableViewCell {

    @IBOutlet weak var textfield: UITextField!{
        didSet{
            textfield.borderStyle = .none
            textfield.font = UIFont(name: "Arial", size: 22)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
