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

class CategoryViewModel : NSObject ,PCategoryViewModel{
    
    var mControllerObj : Controller!
    var mCategoryVCObj : PCategoryViewController!
    var mCategoryList = [Categorylist]()
    var mTotalCount = 0

    init(obj : PCategoryViewController){
        super.init()
        mCategoryVCObj = obj
        mControllerObj = Controller(categoryVMObj: self)
    }
    
    //method to asking data to controller
    func mGetCategories() {
        mCategoryList = mControllerObj.mGetCategoryDetails()
        mTotalCount = mCategoryList.count
    }
    
    //method to send category details
    func mGetCategoryDetails(index : Int) -> Categorylist {
        return mCategoryList[index]
    }
    
    //method to update category view model
    func updateCategoryViewModel(categortList : [Categorylist]) {
        mCategoryVCObj.updateCategoryViewController()
    }
}
