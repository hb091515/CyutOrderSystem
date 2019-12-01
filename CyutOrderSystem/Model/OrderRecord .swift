//
//  Order.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/18.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation

struct orderrecord: Codable {
    
    var orderNo : Int
    
    var orderTime : String
    
    var customerName : String
    
    var email : String
    
    var phoneNumber: String
    
    var total : Int
    
    var salesOrderState : String
    
    var workorderno : [String] = []
}
