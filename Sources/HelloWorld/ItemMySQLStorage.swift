//
//  ItemMySQLStorage.swift
//  HelloWorld
//
//  Created by Bjarne Møller Lundgren on 03/05/2017.
//
//

import Foundation
import MySQL

class ItemMySQLStorage:ItemStorage {
    func getAllItems() -> [Item]? {
        guard let mysql = SQLDb.shared.mysql else { return nil }
        defer { SQLDb.shared.close() }
        
        let pre = MySQLStmt(mysql)
        guard pre.prepare(statement: "SELECT * FROM item ORDER BY title") else {
            print("prepare failed")
            return nil
        }
        
        guard pre.execute() else {
            print("execute failed")
            return nil
        }
        
        var items:[Item] = []
        _ = pre.results().forEachRow { (element:MySQLStmt.Results.Element) in
            
            
            if let id = element[0] as? NSNumber,
               let title = element[1] as? String {
                items.append(Item(id: "\(id.intValue)", title: title))
            } else {
                print("ignoring row...! \(element)")
            }
        }
        
        return items
    }
    
    func getItemWith(id:String) -> Item? {
        guard let mysql = SQLDb.shared.mysql else { return nil }
        defer { SQLDb.shared.close() }
        
        
        let pre = MySQLStmt(mysql)
        guard pre.prepare(statement: "SELECT * FROM item WHERE id = ?") else {
            print("prepare failed")
            return nil
        }
        
        pre.bindParam(id)   // should we convert to Int first?!?!
        
        guard pre.execute() else {
            print("execute failed")
            return nil
        }
        
        var items:[Item] = []
        _ = pre.results().forEachRow { (element:MySQLStmt.Results.Element) in
            
            
            if let id = element[0] as? NSNumber,
                let title = element[1] as? String {
                items.append(Item(id: "\(id.intValue)", title: title))
            } else {
                print("ignoring row...! \(element)")
            }
        }
        
        return items.count > 0 ? items[0] : nil
    }
    
    func updateItem(id:String, newTitle:String) -> Item? {
        guard let mysql = SQLDb.shared.mysql else { return nil }
        defer { SQLDb.shared.close() }
        
        let pre = MySQLStmt(mysql)
        guard pre.prepare(statement: "UPDATE item SET title = ? WHERE id = ?") else {
            print("prepare failed")
            return nil
        }
        
        pre.bindParam(newTitle)
        pre.bindParam(id)   // should we convert to Int first?!?!
        
        guard pre.execute() else {
            print("execute failed")
            return nil
        }
        
        return Item(id: id, title: newTitle)
    }
    
    func addItem(title:String) -> Item? {
        guard let mysql = SQLDb.shared.mysql else { return nil }
        defer { SQLDb.shared.close() }
        
        let pre = MySQLStmt(mysql)
        guard pre.prepare(statement: "INSERT INTO item (title) VALUES(?)") else {
            print("prepare failed")
            return nil
        }
        
        pre.bindParam(title)
        
        guard pre.execute() else {
            print("execute failed")
            return nil
        }
        
        return Item(id: "\(pre.insertId())", title: title)
    }
    
    @discardableResult func deleteItem(id:String) -> Bool {
        guard let mysql = SQLDb.shared.mysql else { return false }
        defer { SQLDb.shared.close() }
        
        let pre = MySQLStmt(mysql)
        guard pre.prepare(statement: "DELETE FROM item WHERE id = ? LIMIT 1") else {
            print("prepare failed")
            return false
        }
        
        pre.bindParam(id)   // should we convert to Int first?!?!
        
        return pre.execute()
    }
}
