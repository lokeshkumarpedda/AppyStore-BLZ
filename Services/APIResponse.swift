//
//  APIResponse.swift
//  AppyStoreBLZ
//
//  Created by Shelly on 01/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit

class APIResponse: NSObject {

    override init() {
        super.init()
    }
    
    //method to parse category list
    func mParseCategoryDetails(response : [String : AnyObject]) {     //response : [String : AnyObject]

        var categories = [categorylist]()
        let count = response["Responsedetails"]!["category_count"] as! Int
        for i in 0..<count {
            let title = response["Responsedetails"]!["category_id_array"]!![i]["category_name"] as! String
            let image = response["Responsedetails"]!["category_id_array"]!![i]["image_path"]!!["50x50"] as! String
            let cId = Int(response["Responsedetails"]!["category_id_array"]!![i]["category_id"] as! String)
            let pId = Int(response["Responsedetails"]!["category_id_array"]!![i]["parent_category_id"] as! String)
            let totalCount = response["Responsedetails"]!["category_count"] as! Int
            
            categories.append(categorylist(name: title, image: image, cId: cId!, pId: pId!, totalCount: totalCount))
        }

        NSNotificationCenter.defaultCenter().postNotificationName("ControllerCategoryUpdate", object: self, userInfo: ["category" : categories])
    }
   
    //method to parse subcategory list
    func mParseSubCategoryDetails(response : [String : AnyObject]) {
        var subcategories = [SubCategorylist]()
        
        let Totalcount = response["Responsedetails"]!["total_count"] as! Int
        let count = response["Responsedetails"]!["data_array"]!!.count as Int
        for i in 0..<count {
            
            let title = response["Responsedetails"]!["data_array"]!![i]["title"] as! String
            let imageUrl = response["Responsedetails"]!["data_array"]!![i]["image_path"] as! String
            let duration = response["Responsedetails"]!["data_array"]!![i]["content_duration"] as! String
            let downloadUrl = response["Responsedetails"]!["data_array"]!![i]["dnld_url"] as! String

            subcategories.append(SubCategorylist(title: title, duration: duration, downloadUrl: downloadUrl, imageUrl: imageUrl, totalCount: Totalcount))
        }

        NSNotificationCenter.defaultCenter().postNotificationName("ControllerSubCategoryUpdate", object: self, userInfo: ["SubCategory" : subcategories])
    }
    
    //method to parse Search category list 
    func mParseSearchCategoryList(controllerObj : PController,response : [String : AnyObject]) {
        var subcategories = [SubCategorylist]()
        //search result found
        if response["ResponseMessage"] as! String == "Success"{
            let Totalcount = response["Responsedetails"]?[0]!["total_count"] as! Int
            let count = response["Responsedetails"]![0]!["data_array"]!!.count as Int
            
            for i in 0..<count {
                let title = response["Responsedetails"]![0]!["data_array"]!![i]["title"] as! String
                let imageUrl = response["Responsedetails"]![0]!["data_array"]!![i]["image_path"] as! String
                let downloadUrl = response["Responsedetails"]![0]!["data_array"]!![i]["dnld_url"] as! String
                
                

                subcategories.append(SubCategorylist(title: title, duration: "00.00", downloadUrl: downloadUrl, imageUrl: imageUrl, totalCount: Totalcount))
                
            }
            
            controllerObj.updateSearchCategoryList(subcategories)
        }
        //No Search Results found
        else {
            controllerObj.updateSearchCategoryList(subcategories)
        }
    }
}
