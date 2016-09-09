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
    var mTotalSubCategoryCount = 8    //varible to store total number of subCategories
    var mReceivedCategoryCount = 0 //variable to store number of recived categories
    var mCategory : Categorylist! // varibale to store total selected category
    var mSubCategoryVCobj : SubCategoryViewContoller!
    init(subCategoryVCobj: SubCategoryViewContoller, category : Categorylist) {
        super.init()
        mCategory = category
        mSubCategoryVCobj = subCategoryVCobj
        mControllerObj = Controller(subCategoryVMobj: self)
    }
    
    //method to fetch subcategory details from controller
    func mFetchSubCategoryDetailsFromController (c_Id : Int,p_Id : Int,offSet : Int) {
        
        mControllerObj.mGetSubCategoryDetails(c_Id, pId: p_Id, offSet: offSet)
    }
    
    //method to send sub category details 
    func mGetSubCategory(index : Int) -> SubCategorylist? {
        if index < mSubcategoryList.count {
            return mSubcategoryList[index]
        }
        else {
            //every eigth index it will call method to fetch data from rest
            if index%8 == 0 {
                //method calling to fetch data 
                mFetchSubCategoryDetailsFromController(mCategory.categoryId, p_Id: mCategory.parentId, offSet: index)
            }
            //creating dummy data
            let category = SubCategorylist(title: "", duration: "", downloadUrl: "", imageUrl: "", totalCount: index)
            mSubcategoryList.append(category)
            //mSubcategoryList.insert(category, atIndex: index)
            //return mSubcategoryList[index]
            return category
        }
    }
    
    //mehtod to update subcategory list in sub category view controller
    func updateSubCategoryViewModel(subCatList : [SubCategorylist]){
        var subCategoryList = subCatList
        
        mTotalSubCategoryCount = subCategoryList[0].totalCount
        //adding content to list
        for category in subCategoryList {
            //if search result don't have dummy value
            if mReceivedCategoryCount < mSubcategoryList.count {
                mSubcategoryList[mReceivedCategoryCount] = category
            }
                //if search list contain dummy value
            else {
                mSubcategoryList.insert(category, atIndex: mReceivedCategoryCount)
            }
            mReceivedCategoryCount += 1
        }
        
        if mReceivedCategoryCount < 9{
            mSubCategoryVCobj.updataSubCategoryViewController()
            NSNotificationCenter.defaultCenter().postNotificationName("updatePlayList", object: nil)
        }
        mSubCategoryVCobj.updataEachCellInSubCategoryVC()
        NSNotificationCenter.defaultCenter().postNotificationName("updateCellInPlayList", object: nil)
    }
}
