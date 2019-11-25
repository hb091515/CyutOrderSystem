//
//  Member.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/11/24.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation

struct member : Codable{
    
    var id : String?
    
    var password : String?
    
    var student : detail?
    
    var userId : String?
    
    
}

struct detail : Codable{
    
    var email : String?
    
    var name : String?
    
    var phoneNumber : String?
}


extension member {
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
