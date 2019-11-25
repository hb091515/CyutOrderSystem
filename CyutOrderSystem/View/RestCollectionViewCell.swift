//
//  RestCollectionViewCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/10/8.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

class RestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var FoodImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
