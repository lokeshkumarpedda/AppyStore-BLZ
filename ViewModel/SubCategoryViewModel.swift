//
//  SubCategoryViewModel.swift
//  AppyStoreBLZ
//
//  Purpose
//  1. This class responsible for getting Subcategory deatils from controller
//  2. And also update Subcategory view controller
//
//  Created by Shelly on 04/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class SubCategoryViewModel: NSObject {
    
    var mControllerObj : Controller!  //create controller object
    var mSubcategoryList :[SubCategorylist] = []  //variable hold list of sub categories details
    var mTotalSubCategoryCount = 0    //varible to store total number of subCategories
    
    var mCategory : Categorylist! // varibale to store total selected category
    init(category : Categorylist) {
        super.init()
        mCategory = category
        mFetchSubCategoryDetailsFromController (0)
    }
    
    //method to fetch subcategory details from controller
    func mFetchSubCategoryDetailsFromController (offSet : Int) {
        
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: #selector(SubCategoryViewModel.updateSubCategoryViewModel(_:)), name: "UpdateSubCategoryViewModel", object: nil)
        mControllerObj = Controller()
        mControllerObj.mGetSubCategoryDetails(mCategory.categoryId, pId: mCategory.parentId, offSet: offSet)
        
    }
    
    //method to send sub category details 
    func mGetSubCategory(index : Int) -> SubCategorylist? {
        if (index+4) > mSubcategoryList.count && index+1 < mTotalSubCategoryCount && index > 0 {
            self.mFetchSubCategoryDetailsFromController(index+1)
        }
        return mSubcategoryList[index]
    }
    
    //mehtod to update subcategory list in sub category view controller
    func updateSubCategoryViewModel(notification : NSNotification){
        var subCategoryList = notification.userInfo!["SubCategory"] as! [SubCategorylist]
        
        mTotalSubCategoryCount = subCategoryList[0].totalCount
        //adding content to list
        for category in subCategoryList {
            mSubcategoryList.append(category)
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UpdateSubCategoryViewModel", object: nil)
        
        
            NSNotificationCenter.defaultCenter()
                .postNotificationName("UpdateSubCategoryViewController", object: nil)
            NSNotificationCenter.defaultCenter()
                .postNotificationName("updatePlayList", object: nil)
      }
}
