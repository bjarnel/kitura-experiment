//
//  Item.swift
//  HelloWorld
//
//  Created by Bjarne Møller Lundgren on 03/05/2017.
//
//

import Foundation

struct Item:Equatable {
    let id:String
    let title:String
    
    var dictionary:[String:Any] {
        return ["id": id, "title": title]
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
