//
//  LocalDataBase.swift
//  AppyStoreBLZ
//

//purpose : Local Sqlite database by using FMDB

//  Created by Shelly on 09/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import FMDB

class LocalDataBase: NSObject {
    var dataBasePath = String()  //to store database file path
    
    override init() {
        
        let fileManager = NSFileManager.defaultManager()
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        dataBasePath = dirPath[0] + "/AppyStoreDatabase.db"
        
        if(fileManager.fileExistsAtPath(dataBasePath)) {
            let AppyStoreDataBase = FMDatabase(path: dataBasePath )
            if (AppyStoreDataBase == nil) {
                print("Error : \(AppyStoreDataBase.lastErrorMessage())")
            }
            else{
                if AppyStoreDataBase.open() {
                    //sql query to create category table
                    let sql_Categort = "CREATE TABLE IF NOT EXISTS CATEGORY (category_name TEXT,category_id INTEGER,parent_category_id INTEGER,image_path TEXT PRIMARY KEY ,TotalCount INTEGER)"
                    
                    //sql query to create history table
                    let sql_History = "CREATE TABLE IF NOT EXISTS HISTORY (title TEXT,content_duration TEXT,image_path TEXT PRIMARY KEY ,DwnLUrl TEXT)"
                    
                    
                    //create category table table
                    if (!AppyStoreDataBase.executeStatements(sql_Categort)){
                        print("Error : \(AppyStoreDataBase.lastErrorMessage())")
                    }
                    //create category table table
                    if (!AppyStoreDataBase.executeStatements(sql_History)) {
                        print("Error : \(AppyStoreDataBase.lastErrorMessage())")
                    }
                    //close Database
                    AppyStoreDataBase.close()
                }
                else {
                    print("failed to open db \(AppyStoreDataBase.lastErrorMessage())")
                }
            }
        }
    }

    
    
    //method to insert into category table
    func mInsertInToCategoryTable(category : Categorylist) {
        let AppyStoreDataBase = FMDatabase(path: dataBasePath)
        //opening database
        if AppyStoreDataBase.open() {
            let insertSql = "INSERT INTO CATEGORY (category_name,category_id,parent_category_id,image_path,TotalCount) VALUES ('\(category.name.value)','\(category.categoryId)','\(category.parentId)','\(category.image)','\(category.totalCount)')"
            //execute insert statement
            if (AppyStoreDataBase.executeStatements(insertSql)) {
                print("Data inserted")
            }
            else {
                print("Failed to insert values into table")
            }
            AppyStoreDataBase.close() //closing database
        }
    }
    
    //method to insert into history table
    func mInsertInToHistoryTabel(content : SubCategorylist) {
        let AppyStoreDataBase = FMDatabase(path: dataBasePath)
        //opening database
        if AppyStoreDataBase.open() {
            
            let title = content.title.value
            let dwldUrl = content.downloadUrl.value
            let duration = content.duration.value
            let imageUrl = content.imageUrl

            //insert query
            let insertSql = "INSERT INTO HISTORY (title,content_duration,image_path,DwnLUrl) VALUES ('\(title)','\(duration)','\(imageUrl!)','\(dwldUrl)')"
            //execute insert statement
            if (AppyStoreDataBase.executeStatements(insertSql)) {
                print("Data inserted")
            }
            else {
                print("Failed to insert values into table")
            }
            AppyStoreDataBase.close() //closing database
        }
    }
    
    //mehtod to fetch category list
    func mFetchCategoryDetails() -> [Categorylist] {
        var categories = [Categorylist]()
        let AppyStoreDataBase = FMDatabase(path: dataBasePath)
        //opening database
        if AppyStoreDataBase.open() {
            //fetch query
            let querySql = "SELECT * FROM CATEGORY"
            let result : FMResultSet? = AppyStoreDataBase.executeQuery(querySql, withArgumentsInArray: nil)
            if (result?.next() == true) {
                while result!.next() {
                    let category = Categorylist(name: result!.stringForColumn("category_name"), image: result!.stringForColumn("image_path"), cId: Int((result?.stringForColumn("category_id"))!)!, pId: Int((result?.intForColumn("parent_category_id"))!), totalCount: Int((result?.intForColumn("TotalCount"))!))
                    categories.append(category)
                }
            }
            else {
                print("Failed to fetch data from database")
            }
            AppyStoreDataBase.close() //closing database
        }
        return categories
    }
    
    func mFetchHistoryDetails() -> [SubCategorylist]  {
        var history = [SubCategorylist]()
        let AppyStoreDataBase = FMDatabase(path: dataBasePath)
        //opening database
        if AppyStoreDataBase.open() {
            //fetch query for history
            let querySql = "SELECT * FROM HISTORY"
            //execute query
            let result = AppyStoreDataBase.executeQuery(querySql, withArgumentsInArray: nil)
            if (result != nil) {
                while result.next() {
                    
                    let category = SubCategorylist(title: result.stringForColumn("title"), duration: result.stringForColumn("content_duration"), downloadUrl: result.stringForColumn("DwnLUrl"), imageUrl: result.stringForColumn("image_path")!, totalCount: 0)
                    
                    history.append(category)
                }
            }
            else {
                print("Failed to fetch data from database")
            }
            
            AppyStoreDataBase.close()  //closing database
        }
        return history
    }

    //For clearing the data in the history table
    //returns tru if clear fase if not
    func clearHistory() -> Bool{
        var cleared = false
        let AppyStoreDataBase = FMDatabase(path: dataBasePath)
        //checking if database exists or not
        if (AppyStoreDataBase == nil) {
            print("Error : \(AppyStoreDataBase.lastErrorMessage())")
        }
        else{
            //Opening the database
            if AppyStoreDataBase.open() {
                //Deleting the whole table
                let dropTable = "DELETE FROM HISTORY"
                if AppyStoreDataBase.executeUpdate(dropTable, withArgumentsInArray: nil){
                    cleared = true
                }
                //sql query to create history table
                let sql_History = "CREATE TABLE IF NOT EXISTS HISTORY (title TEXT,content_duration TEXT,image_path TEXT PRIMARY KEY ,DwnLUrl TEXT)"
                
                //create category table table
                if (!AppyStoreDataBase.executeStatements(sql_History)) {
                    print("Error : \(AppyStoreDataBase.lastErrorMessage())")
                }
                //close Database
                AppyStoreDataBase.close()
            }
            else {
                print("failed to open db \(AppyStoreDataBase.lastErrorMessage())")
            }
        }
        
        return cleared
    }
}
