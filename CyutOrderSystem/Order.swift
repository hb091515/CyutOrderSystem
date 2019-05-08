//
//  Order.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/4/20.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation

struct Order: Codable {
    var id: Int
    var name: String
    var price: Int
    var imgName: String
    var quantity: Int
    
    var supplier : Supplier
}

struct Supplier: Codable {
    var supplierNo: Int
    var supplierName: String
    var introduciton: String
    var location: String
    
   
}
