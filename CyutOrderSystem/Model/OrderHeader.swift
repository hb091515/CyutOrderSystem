//
//  OrderDetail.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/22.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation

struct orderheader: Codable {
    
    var orderNo : Int?
    
    var orderTime : String?
    
    var customerName : String?
    
    var email : String?
    
    var phoneNumber: String?
    
    var totalPrice : Int?
    
    var workorderno: [String] = []
}
