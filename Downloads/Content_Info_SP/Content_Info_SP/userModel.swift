//
//  userModel.swift
//  Content_Info_SP
//
//  Created by BridgeLabz on 16/02/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class userModel: Model {
    
    var databasePath = String()
    var path : String?
    
    func save() {
        
        
        
        
    }
    
    
    //create table
    func createTable() -> String
    {
        
        databasePath = Model().createDatabase("UserDB")
        path = databasePath
        print (path!)
            print("inside create table" , databasePath)
            let UserDB = FMDatabase(path: databasePath as String)
            print("path ", UserDB)
        
            if UserDB.open() {
                
                let sql_stmt = "CREATE TABLE IF NOT EXISTS Users (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, PASSWORD TEXT)"
                if !UserDB.executeStatements(sql_stmt) {
                    print("Error: \(UserDB.lastErrorMessage())")
                }
                UserDB.close()
            } else {
                print("Error: \(UserDB.lastErrorMessage())")
            }
        return databasePath
    }

    //save the data
    func saveData(dataPath : String ,userName: String , password : String) {
        
        
        print("enter into save data")
        let userDB = FMDatabase(path : dataPath)
        var status = Bool()
        print ("datapath User ", dataPath )
        if userDB.open()
        {
            print("NAme", (userName))
            
            
            let insertQuery = "INSERT INTO Users(NAME,PASSWORD) VALUES('\((userName))','\((password))')"
            
            let result = userDB.executeUpdate(insertQuery, withArgumentsInArray: nil)
            if !result {
                status = true
                print("Error: \(userDB.lastErrorMessage())")
            } else {
                status = false
               
            }
        }
        else {
            print("Error: \(userDB.lastErrorMessage())")
        }
       print("value of bool = ",status)
        
    }
    
    func fetchData()
    {
        
    }

    
    
}
