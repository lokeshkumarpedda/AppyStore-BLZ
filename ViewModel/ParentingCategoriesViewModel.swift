//
//  ParentingCategoriesViewModel.swift
//  AppyStoreBLZ
//
//  Created by BridgeLabz on 08/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class ParentingCategoriesViewModel: NSObject {
    
    var mControllerObj : Controller!
    var mParentCategoryVCobj : ParentingCategoriesCollectionViewController!
    var mParentCategoryList = [Categorylist]()
    
    init(parentCategoryVCobj : ParentingCategoriesCollectionViewController){
        super.init()
        mControllerObj = Controller(parentCategoryVMobj: self)
        mParentCategoryVCobj = parentCategoryVCobj
        mControllerObj.mGetParentCategories()
    }
    
    func mUpdateViewModel(parentCategories : [Categorylist]) {
        mParentCategoryList = parentCategories
        mParentCategoryVCobj.updateVC()
    }
    
    
    func getCellsCount() -> Int {
        return mParentCategoryList.count
    }
    
    func getCellValues(index : Int) -> Categorylist {
        return mParentCategoryList[index]
    }
}
