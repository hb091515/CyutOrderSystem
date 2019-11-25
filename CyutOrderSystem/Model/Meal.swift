//
//  File.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/11.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation

struct meal: Codable, Equatable {
    var id : Int
    var name : String
    var price : Int
}

extension meal {
    //判斷有無重複加入
    static func == (lhs: meal, rhs: meal) -> Bool{
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.id == rhs.id
    }
    
    func displayPrice() -> String {
        return String.init(price)
    }
}
