//
//  ParentingSubcategoryViewModel.swift
//  AppyStoreBLZ
//
//  Purpose : displaying the parenting subcategories with videos
//
//  Created by Lokesh kumar on 10/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class ParentingSubcategoryViewModel: NSObject {
    var mControllerObj : Controller!    //create controller object
    var mParentSubcategoryList :[SubCategorylist] = []
                                        //variable hold list of sub categories details
    var mTotalParentSubCategoryCount = 0
                                        //store total number of ParentsubCategories
    var mCategory : Categorylist!       // varibale to store total selected category
    
    init(parentingSubCategory : Categorylist) {
        super.init()
        
        //getting the selected parent category
        mCategory = parentingSubCategory
        
        //fetching the subcategories
        mFetchParentSubCategoryDetailsFromController(0)
    }
    
    //method to fetch subcategory details from controller
    func mFetchParentSubCategoryDetailsFromController (offSet : Int) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateParentSubCategoryViewModel(_:)), name: "UpdateParentSubCategoryViewModel", object: nil)
        mControllerObj = Controller()
        
        //Asking controller for data
        mControllerObj.mGetParentSubCategoryDetails(mCategory.categoryId, pId: mCategory.parentId, offSet: offSet)
    }
    
    //method to send sub category details
    func mGetParentSubCategory(index : Int) -> SubCategorylist? {
        
        //making the call when we get to the bottom of the collection view
        if (index+2) > mParentSubcategoryList.count && index+1 < mTotalParentSubCategoryCount && index > 0{
            mFetchParentSubCategoryDetailsFromController(index+1)
        }
        return mParentSubcategoryList[index]
    }
    
    //method to update subcategory list in sub category view controller
    func updateParentSubCategoryViewModel(notification : NSNotification){
        var parentSubCategoryList = notification.userInfo!["ParentSubCategory"] as! [SubCategorylist]
        
        //storing the total categories count
        mTotalParentSubCategoryCount = parentSubCategoryList[0].totalCount
        
        //adding content to list
        for category in parentSubCategoryList {
            mParentSubcategoryList.append(category)
        }
        
        //removing the observer for this view model
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UpdateParentSubCategoryViewModel", object: nil)
        
        //posting a notification to update view controller
        NSNotificationCenter.defaultCenter().postNotificationName("UpdateParentSubCategoryViewController", object: nil)
    }
}
