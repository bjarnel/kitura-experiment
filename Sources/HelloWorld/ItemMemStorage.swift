//
//  ItemMemStorage.swift
//  HelloWorld
//
//  Created by Bjarne Møller Lundgren on 03/05/2017.
//
//

import Foundation

class ItemMemStorage:ItemStorage {
    private var items:[Item] = [
        Item(id: "test", title: "Test Item 1"),
        Item(id: UUID().uuidString.lowercased(), title: "Test Item 2")
    ]
    
    func getAllItems() -> [Item]? {
        return items
    }
    
    func getItemWith(id:String) -> Item? {
        return items.filter { $0.id == id }.first
    }
    
    func updateItem(id:String, newTitle:String) -> Item? {
        if let info = items.enumerated().filter( { $1.id == id } ).first {
            let updatedItem = Item(id: id, title: newTitle)
            items[info.offset] = updatedItem
            return updatedItem
        }
        return nil
    }
    
    func addItem(title:String) -> Item? {
        let newItem = Item(id: UUID().uuidString.lowercased(), title: title)
        items.append(newItem)
        return newItem
    }
    
    @discardableResult func deleteItem(id:String) -> Bool {
        if let info = items.enumerated().filter( { $1.id == id } ).first {
            items.remove(at: info.offset)
        }
        return true
    }
}
