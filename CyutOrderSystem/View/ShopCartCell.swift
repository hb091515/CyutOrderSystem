//
//  ShopCartCell.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/4/20.
//  Copyright © 2019 yacheng. All rights reserved.
//

import UIKit

protocol CartItemDelegate {
    func updateCartItem(cell: ShopCartCell, quantity: Int)
}
class ShopCartCell: UITableViewCell {

    @IBOutlet weak var cartName: UILabel!
    @IBOutlet weak var cartPrice: UILabel!
    @IBOutlet weak var cartQuantity: UILabel!

    
    var delegate: CartItemDelegate?

    var quantity : Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func Stepper(_ sender: UIStepper) {
        quantity = Int(sender.value)
        
        self.cartQuantity.text = String(quantity)
        self.delegate?.updateCartItem(cell: self, quantity: quantity)
    }

}
