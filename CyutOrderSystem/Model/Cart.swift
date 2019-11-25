//
//  ShopCart.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/4/20.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation

class Cart {
    
    var items : [CartItem] = []
}

class CartItem {
    
    var quantity : Int = 1
    
    var meal : meal
    
    var total : Int{ get { return meal.price * quantity } }
    
    init(meal : meal) {
        self.meal = meal
    }
}

extension Cart {
    var total: Int {
        get { return items.reduce(0) { value, item in
            value + item.total
            }
        }
    }
    
    var totalQuantity : Int {
        get { return items.reduce(0) { value, item in
            value + item.quantity
            }
        }
    }
    
    func updateCart(with meal: meal) {
        if !self.contains(meal: meal) {
            self.add(meal: meal)
        } else {
            self.remove(meal: meal)
        }
    }
    
    func updateCart() {
        for item in self.items {
            if item.quantity == 0 {
                updateCart(with: item.meal)
            }
        }
    }
    
    func add(meal: meal) {
        let item = items.filter { $0.meal == meal }
        
        if item.first != nil {
            item.first!.quantity += 1
        } else {
            items.append(CartItem(meal: meal))
        }
    }
    
    func remove(meal: meal) {
        guard let index = items.firstIndex(where: { $0.meal == meal }) else { return }
        items.remove(at: index)
    }
    

    
    func contains(meal: meal) -> Bool {
        let item = items.filter { $0.meal == meal }
        return item.first != nil
    }
    
    
}


