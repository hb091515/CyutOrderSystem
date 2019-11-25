//
//  Order.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/4/20.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation


struct salesorder: Codable {
    
    var customerName : String?
    
    var phoneNumber : String?
    
    var email : String?
    
    var lines : [orderline] = []
    
}

struct orderline: Codable {
    
    var item: item
}

struct item: Codable {
    
    var id: Int?
    
    var quantity : Int?
}

extension salesorder {
    func ToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
        return dict
    }
}

