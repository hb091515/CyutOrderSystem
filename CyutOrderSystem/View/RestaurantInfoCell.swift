//
//  RestaurantInfoCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/11.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

protocol CartDelegate {
    func updateCart(cell: RestaurantInfoCell)
}


class RestaurantInfoCell: UITableViewCell {

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var addtoCart: UIButton!
    
    var delegate: CartDelegate?

    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addtoCart.layer.cornerRadius = 4
        addtoCart.clipsToBounds = true
        // Initialization code
    }

    //使點選cell時, 不改變其他物件的背景顏色
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setButton(state: Bool) {
        addtoCart.isSelected = state
        addtoCart.backgroundColor = (!addtoCart.isSelected) ? .orange : .lightGray
    }
    @IBAction func addtocartButton(_ sender: UIButton) {
        setButton(state: !addtoCart.isSelected)
        self.delegate?.updateCart(cell: self)
    }

}
