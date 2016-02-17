//
//  model.swift
//  Content_Info_SP
//
//  Created by BridgeLabz on 16/02/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit





class Model : NSObject
    
{
    func createDatabase(nameOfTheDataBase: String  ) ->String
    {
        
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as! NSString
        let databasePath = docsDir.stringByAppendingPathComponent(
            nameOfTheDataBase)
        
        
        if !filemgr.fileExistsAtPath(databasePath as String) {
            
            let DB = FMDatabase(path: databasePath as String)
            print("path ", DB)
            if DB == nil {
                print("Error: \(DB.lastErrorMessage())")
                
            }
            
            
        }
        
        
        
        
        
      return databasePath
    }
    
    
    
    
    
    
}





