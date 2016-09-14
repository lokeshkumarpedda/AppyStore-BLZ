//
//  ParentingCategoriesViewModel.swift
//  AppyStoreBLZ
//
//  Purpose:
//  For getting the parent categories from controller and giving it to the parenting category view controller
//
//  Created by Lokesh Kumar on 08/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class ParentingCategoriesViewModel: NSObject {
    
    var mControllerObj : Controller!            //creating controller model object
    var mParentCategoryVCobj : ParentingCategoriesCollectionViewController!
                                                //creating view controller object
    var mParentCategoryList = [Categorylist]()  //creating array of category list
    
    //construter with view controller object
    init(parentCategoryVCobj : ParentingCategoriesCollectionViewController){
        super.init()
        mControllerObj = Controller(parentCategoryVMobj: self)
        mParentCategoryVCobj = parentCategoryVCobj
        mControllerObj.mGetParentCategories()
    }
    
    //updating the view model when the response came
    func mUpdateViewModel(parentCategories : [Categorylist]) {
        mParentCategoryList = parentCategories
        mParentCategoryVCobj.updateVC()
    }
    
    //giving cells count to the view controller
    func getCellsCount() -> Int {
        return mParentCategoryList.count
    }
    
    //giving cell values to the view controller
    func getCellValues(index : Int) -> Categorylist {
        return mParentCategoryList[index]
    }
}
