//
//  APIResponse.swift
//  AppyStoreBLZ
//
//  Created by Shelly on 01/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class APIResponse: NSObject {

    override init() {
        super.init()
    }
    
    //method to parse category list
    func mParseCategoryDetails(controllerObj: PController , response : [String : AnyObject]) {     //response : [String : AnyObject]

        var categories = [Categorylist]()
        let count = response["Responsedetails"]!["category_count"] as! Int
        for i in 0..<count {
            let title = response["Responsedetails"]!["category_id_array"]!![i]["category_name"] as! String
            let image = response["Responsedetails"]!["category_id_array"]!![i]["image_path"]!!["50x50"] as! String
            let cId = Int(response["Responsedetails"]!["category_id_array"]!![i]["category_id"] as! String)
            let pId = Int(response["Responsedetails"]!["category_id_array"]!![i]["parent_category_id"] as! String)
            let totalCount = response["Responsedetails"]!["category_count"] as! Int
            
            categories.append(Categorylist(name: title,
                                            image: image,
                                            cId: cId!,
                                            pId: pId!,
                                            totalCount: totalCount))
        }
        controllerObj.updateCategoryDetails(categories)
    }
   
    //method to parse subcategory list
    func mParseSubCategoryDetails(controllerObj: PController,
                                  response : [String : AnyObject]) {
        var subcategories = [SubCategorylist]()
        
        let totalcount = response["Responsedetails"]!["total_count"] as! Int
        let count = response["Responsedetails"]!["data_array"]!!.count as Int
        for i in 0..<count {
            
            let title = response["Responsedetails"]!["data_array"]!![i]["title"] as! String
            let imageUrl = response["Responsedetails"]!["data_array"]!![i]["image_path"] as! String
            let duration = response["Responsedetails"]!["data_array"]!![i]["content_duration"] as! String
            let downloadUrl = response["Responsedetails"]!["data_array"]!![i]["dnld_url"] as! String

            subcategories.append(SubCategorylist(title: title,
                                                    duration: duration,
                                                    downloadUrl: downloadUrl,
                                                    imageUrl: imageUrl,
                                                    totalCount: totalcount))
        }
        controllerObj.updateSubCategoryList(subcategories)
    }
    
    //method to parse Search category list 
    func mParseSearchCategoryList(controllerObj : PController,
                                  response : [String : AnyObject]) {
        var subcategories = [SubCategorylist]()
        //search result found
        if response["ResponseMessage"] as! String == "Success"{
            let totalcount = response["Responsedetails"]?[0]!["total_count"] as! Int
            let count = response["Responsedetails"]![0]!["data_array"]!!.count as Int
            
            for i in 0..<count {
                let title = response["Responsedetails"]![0]!["data_array"]!![i]["title"] as! String
                let imageUrl = response["Responsedetails"]![0]!["data_array"]!![i]["image_path"] as! String
                let downloadUrl = response["Responsedetails"]![0]!["data_array"]!![i]["dnld_url"] as! String
                let duration = response["Responsedetails"]![0]!["data_array"]!![i]["content_duration"] as! String

                subcategories.append(SubCategorylist(title: title,
                                                        duration: duration,
                                                        downloadUrl: downloadUrl,
                                                        imageUrl: imageUrl,
                                                        totalCount: totalcount))
                
            }
            
            controllerObj.updateSearchCategoryList(subcategories)
        }
        //No Search Results found
        else {
            controllerObj.updateSearchCategoryList(subcategories)
        }
    }
    
    //method to parse parent categories
    func mParseParentCategories(controllerObj : PController,
                                response : [String : AnyObject]) {
        var parentCategories = [Categorylist]()
        let count = response["Responsedetails"]!["category_count"] as! Int
        for i in 0..<count {
            let title = response["Responsedetails"]!["category_id_array"]!![i]["category_name"] as! String
            let image = response["Responsedetails"]!["category_id_array"]!![i]["image_path"]!!["50x50"] as! String
            let cId = Int(response["Responsedetails"]!["category_id_array"]!![i]["category_id"] as! String)
            let pId = Int(response["Responsedetails"]!["category_id_array"]!![i]["parent_category_id"] as! String)
            let totalCount = response["Responsedetails"]!["category_count"] as! Int
            
            parentCategories.append(Categorylist(name: title,
                                                    image: image,
                                                    cId: cId!,
                                                    pId: pId!,
                                                    totalCount: totalCount))
        }
        controllerObj.updateParentCategoryList(parentCategories)
    }
    
    //method to parse parent subcategory list
    func mParseParentSubCategoryDetails(controllerObj : PController,
                                        response : [String : AnyObject]) {
        var subcategories = [SubCategorylist]()
        
        let totalcount = response["Responsedetails"]!["total_count"] as! Int
        let count = response["Responsedetails"]!["data_array"]!!.count as Int
        for i in 0..<count {
            
            let title = response["Responsedetails"]!["data_array"]!![i]["title"] as! String
            let imageUrl = response["Responsedetails"]!["data_array"]!![i]["image_path"] as! String
            let duration = response["Responsedetails"]!["data_array"]!![i]["content_duration"] as! String
            let downloadUrl = response["Responsedetails"]!["data_array"]!![i]["dnld_url"] as! String
            
            subcategories.append(SubCategorylist(title: title,
                                                    duration: duration,
                                                    downloadUrl: downloadUrl,
                                                    imageUrl: imageUrl,
                                                    totalCount: totalcount))
        }
        controllerObj.updateParentSubCategoryList(subcategories)
    }
    
    //method to parse avatar list
    func mParseAvatarList(controllerObj: PController,response : [String : AnyObject]){
        var avatarList = [Avatar]()
        
        let count = response["Responsedetails"]!.count as Int
        
        for i in 0..<count{
            let avatarId = response["Responsedetails"]![i]["avatarID"] as! Int
            let avatarUrl = response["Responsedetails"]![i]["avatarIMG"] as!String
            
            avatarList.append(Avatar(id: avatarId, url: avatarUrl))
        }
        controllerObj.updateAvatars(avatarList)
    }
    
    //method to get the child registratoin response
    func mRegistrationRespone(response : [String : AnyObject]) {
        
        let message = response["ResponseMessage"] as! String
        if message == "Success"{
            let name = response["childlist"]![0]["childName"] as! String
            let dateOfBirth = response["childlist"]![0]["dob"] as! String
            let age = response["childlist"]![0]["age"] as! String
            let childId = response["childlist"]![0]["childId"] as! String
            let avatarId = response["childlist"]![0]["avatarId"] as! String
            let avatarUrl = response["childlist"]![0]["avatarIMG"] as! String
            let childDetails = ChildDetails(name: name,
                                            dob: dateOfBirth,
                                            age: Int(age)!,
                                            childId: Int(childId)!,
                                            avatarId: Int(avatarId)!,
                                            avatarUrl: avatarUrl)
            
            //encoding the class object to store in the nsuser defaults
            let defaults = NSUserDefaults.standardUserDefaults()
            let encodedData = NSKeyedArchiver.archivedDataWithRootObject(childDetails)
            defaults.setObject(encodedData, forKey: "childInformation")
            
            //posting notification with successfull registration
            NSNotificationCenter.defaultCenter().postNotificationName(
                "RegistrationSuccess",
                object: self,
                userInfo: nil)
            
        }
        else{
            //For registration failure
            NSNotificationCenter.defaultCenter().postNotificationName(
                "RegistrationFailed", object: self, userInfo: nil)
        }
    }
}
