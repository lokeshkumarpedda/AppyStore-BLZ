//
//  ParentingSubcategoryViewModel.swift
//  AppyStoreBLZ
//
//  Created by Lokesh kumar on 10/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class ParentingSubcategoryViewModel: NSObject {
    var mControllerObj : Controller!  //create controller object
    var mParentSubcategoryList :[SubCategorylist] = []  //variable hold list of sub categories details
    var mTotalParentSubCategoryCount = 0 //varible to store total number of ParentsubCategories
    var mCategory : Categorylist! // varibale to store total selected category
    init(parentingSubCategory : Categorylist) {
        super.init()
        mCategory = parentingSubCategory
        mFetchParentSubCategoryDetailsFromController(0)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateParentSubCategoryViewModel(_:)), name: "UpdateParentSubCategoryViewModel", object: nil)
    }
    
    //method to fetch subcategory details from controller
    func mFetchParentSubCategoryDetailsFromController (offSet : Int) {
        
        mControllerObj = Controller()
        mControllerObj.mGetParentSubCategoryDetails(mCategory.categoryId, pId: mCategory.parentId, offSet: offSet)
    }
    
    //method to send sub category details
    func mGetParentSubCategory(index : Int) -> SubCategorylist? {
        return mParentSubcategoryList[index]
    }
    
    //method to update subcategory list in sub category view controller
    func updateParentSubCategoryViewModel(notification : NSNotification){
        var parentSubCategoryList = notification.userInfo!["ParentSubCategory"] as! [SubCategorylist]
        
        mTotalParentSubCategoryCount = parentSubCategoryList[0].totalCount
        //adding content to list
        for category in parentSubCategoryList {
            mParentSubcategoryList.append(category)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("UpdateParentSubCategoryViewController", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UpdateParentSubCategoryViewModel", object: nil)

    }
}
