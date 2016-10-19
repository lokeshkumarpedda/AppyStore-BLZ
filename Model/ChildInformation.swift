//
//  AvatarListModel.swift
//  AppyStoreBLZ
//
//  Created by Lokesh Kumar on 18/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

//Structure to store avatar details
class Avatar {
    var avatarId : Int
    var avatarUrl : String?
    
    init(id: Int , url: String){
        self.avatarId = id
        self.avatarUrl = url
    }
}


//registered child details
//this class is conform to NSCoding
class ChildDetails: NSObject, NSCoding {
    var childName: String?
    var dateOfBirth: String?
    var age: Int?
    var childId: Int?
    var avatarId: Int?
    var avatarUrl: String?
    
    init(name : String ,
         dob: String,
         age: Int,
         childId: Int,
         avatarId: Int,
         avatarUrl: String){
        
        self.childName = name
        self.dateOfBirth = dob
        self.age = age
        self.childId = childId
        self.avatarId = avatarId
        self.avatarUrl = avatarUrl
    }
    required convenience init(coder aDecoder: NSCoder) {
        let childName = aDecoder.decodeObjectForKey("childName") as! String
        let dateOfBirth = aDecoder.decodeObjectForKey("dateOfBirth") as! String
        let age = aDecoder.decodeIntegerForKey("age")
        let childId = aDecoder.decodeIntegerForKey("childId")
        let avatarId = aDecoder.decodeIntegerForKey("avatarId")
        let avatarUrl = aDecoder.decodeObjectForKey("avatarUrl") as! String
        self.init(name : childName ,
                  dob: dateOfBirth,
                  age: age,
                  childId: childId,
                  avatarId: avatarId,
                  avatarUrl: avatarUrl)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(childName, forKey: "childName")
        aCoder.encodeObject(dateOfBirth, forKey: "dateOfBirth")
        aCoder.encodeInteger(age!, forKey: "age")
        aCoder.encodeInteger(childId!, forKey: "childId")
        aCoder.encodeInteger(avatarId!, forKey: "avatarId")
        aCoder.encodeObject(avatarUrl, forKey: "avatarUrl")

    }
}
