//
//  ItemStorage.swift
//  HelloWorld
//
//  Created by Bjarne Møller Lundgren on 03/05/2017.
//
//

import Foundation

protocol ItemStorage {
    func getAllItems() -> [Item]?
    func getItemWith(id:String) -> Item?
    func updateItem(id:String, newTitle:String) -> Item?
    func addItem(title:String) -> Item?
    @discardableResult func deleteItem(id:String) -> Bool
}
