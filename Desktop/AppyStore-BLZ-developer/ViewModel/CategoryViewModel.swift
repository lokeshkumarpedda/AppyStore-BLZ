//
//  CategoryViewModel.swift
//  AppyStoreBLZ
//  Purpose
//  1. This class responsible for getting category deatils from controller
//  2. And also update category view controller
//
//  Created by Shelly on 04/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class CategoryViewModel : NSObject {
    
    var mControllerObj : Controller!
    var mCategoryList = [Categorylist]()
    var mTotalCount = 0

    override init(){
        super.init()
        mControllerObj = Controller()
        mFetchCategoryDetailsFromController()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CategoryViewModel.updateCategoryViewModel(_:)), name: "UpdateCategoryViewModel", object: nil)
    }
    
    //mehtod to send category details
    func mGetCategoryDetails(index : Int) -> Categorylist {
        return mCategoryList[index]
    }
    
    //method to fetch category list
    func mFetchCategoryDetailsFromController()  {
        mControllerObj.mGetCategoryDetailsFromRest()
    }
    
    //method to update category view model
    func updateCategoryViewModel(notification : NSNotification) {
        mCategoryList = notification.userInfo!["category"] as! [Categorylist]
        mTotalCount = mCategoryList.count
        NSNotificationCenter.defaultCenter().postNotificationName("updateCategoryViewController", object: nil)
    }
}
