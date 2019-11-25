//
//  CartItem.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/19.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation

class CartItem {
    
    var quantity : Int = 1
    
    var meal : meal
    
    var total : Int{ get { return meal.price * quantity } }
    
    init(meal : meal) {
        self.meal = meal
    }
}
