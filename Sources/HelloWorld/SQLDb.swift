//
//  SQLDb.swift
//  HelloWorld
//
//  Created by Bjarne Møller Lundgren on 03/05/2017.
//
//

import Foundation
import MySQL

class SQLDb {
    private let dataMysql = MySQL()
    
    static let shared = SQLDb()
    private (set) var isConnected = false
    
    func connect() -> Bool {
        guard !isConnected else { return true }
        
        // connect to database
        guard dataMysql.connect(host: MysqlConf.host,
                                user: MysqlConf.user,
                                password: MysqlConf.password) else {
            print("unable to connect to database")
            return false
        }
        
        isConnected = true
        
        guard dataMysql.selectDatabase(named: MysqlConf.database) else {
            close()
            print("unable to select database")
            return false
        }
        
        guard dataMysql.setOption(MySQLOpt.MYSQL_SET_CHARSET_NAME, "utf8mb4"),
              dataMysql.query(statement: "SET NAMES utf8mb4") else {
            close()
            print("unable to set charset")
            return false
        }
        
        return true
    }
    
    func close() {
        guard isConnected else { return }
        
        isConnected = false
        dataMysql.close()
    }
    
    var mysql:MySQL? {
        guard isConnected else {
            if connect() {
                return dataMysql
            }
            return nil
        }
        return dataMysql
    }
}
