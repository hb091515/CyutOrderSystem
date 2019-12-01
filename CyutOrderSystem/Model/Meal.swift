//
//  File.swift
//  CyutOrderSystem
//
//  Created by yacheng on 2019/6/11.
//  Copyright © 2019 yacheng. All rights reserved.
//

import Foundation
import Kingfisher

struct meal: Codable, Equatable {
    var imageurl : String
    var id : Int
    var name : String
    var price : Int
}

extension meal {
    //判斷有無重複加入
    static func == (lhs: meal, rhs: meal) -> Bool{
        return lhs.imageurl == rhs.imageurl && lhs.name == rhs.name && lhs.price == rhs.price && lhs.id == rhs.id
    }
    
    func displayPrice() -> String {
        return String.init(price)
    }
}
