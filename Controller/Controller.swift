//
//  Controller.swift
//  AppyStoreBLZ
//  Purpose
//  1. purpose of controller to supply date to view mode from source
//  2. All view models getting data from controller
//  3. Controller have method to update viewmodes
//  
//  Created by Shelly on 04/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class Controller : NSObject,PController{
    
    var mApiRequesrObj = ApiRequest() //create object to make rest call
    var mLocalDataBaseObj = LocalDataBase() //object of local database
    var mCategoryViewModelObj : PCategoryViewModel! //object od category view model
    var mSubCategoryViewModelObj : PSubCategoryViewModel! //object of sub category view model
    var mSearchViewModelObj : PSearchViewModel! //object od search view model
    var mHistoryViewModel : HistoryViewModel! //object of history view model
    var mParentCategoryVMobj : ParentingCategoriesViewModel!
    
    //init for category
    override init() {
        super.init()
        //observe notification for category list updates
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Controller.updateCategoryDetails(_:)), name:"ControllerCategoryUpdate", object: nil)
        //observe notification for subcategory list updates
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Controller.updateSubCategoryList(_:)), name: "ControllerSubCategoryUpdate", object: nil)
        //observe notification for parent sub category list updates
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Controller.updateParentSubCategoryList(_:)), name: "ControllerParentSubCategoryUpdate", object: nil)
        //observe notification for avatar list
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Controller.updateAvatars(_:)), name: "ControllerAvatarsUpdate", object: nil)
        
    }
    //init for search
    init(searchViewMode : PSearchViewModel) {
        mSearchViewModelObj = searchViewMode
    }
    //init for history
    init(historyVMObj : HistoryViewModel) {
        mHistoryViewModel = historyVMObj
    }
    //init for parent categories
    init(parentCategoryVMobj : ParentingCategoriesViewModel) {
        mParentCategoryVMobj = parentCategoryVMobj
    }
    //MARK:- Fetch details methods
    //method to get category list from rest api
    func mGetCategoryDetails() -> [Categorylist]{
        let categoryDetails = mLocalDataBaseObj.mFetchCategoryDetails()
        mApiRequesrObj.mFetchCategoryList()
        
        return categoryDetails
    }
    
    //method to get subcategory from rest api
    func mGetSubCategoryDetails(cId : Int,pId : Int,offSet : Int) {
        mApiRequesrObj.mFetchSubCategoryList(cId,p_Id : pId,offset: offSet)
    }
    
    //medthod to get SearchDetails from api
    func mGetSearchCategory(keyword : String , index : Int) {
        mApiRequesrObj.mFetchSearchDetails(self,keyword: keyword, offset: index)
    }
    
    //method to get history details
    func mGetHistoryRecords() ->[SubCategorylist] {
        return mLocalDataBaseObj.mFetchHistoryDetails()
    }
    
    //method to clear history
    func clearHistory() -> Bool {
        return mLocalDataBaseObj.clearHistory()
    }
    
    //method to get parent categories
    func mGetParentCategories() {
        mApiRequesrObj.mFetchParentCategories(self)
    }
    
    //method to get parent subcategories
    func mGetParentSubCategoryDetails(cId : Int,pId : Int,offSet : Int) {
        mApiRequesrObj.mFetchSubParentingCategories(cId,p_Id : pId,offset: offSet)
    }
    
    //method to get avatar list
    func mGetAvatars() {
        mApiRequesrObj.mFetchAvatarList()
    }
    
    //method to registering a child
    func mRegisterChildDetails(name: String , dob: String , avatarId: Int) {
        mApiRequesrObj.mRegisterChild(name, dob: dob, avatarId: avatarId)
    }
    
    //MARK:- Updating methods
    //method to save played video in local database
    func mSaveVideoInHistory(subCategory : SubCategorylist) {
        mLocalDataBaseObj.mInsertInToHistoryTabel(subCategory)
    }
    //method to update category view model
    func updateCategoryDetails(notification : NSNotification){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ControllerCategoryUodate", object: nil)
        if mLocalDataBaseObj.mCheckCategoryUpdates(notification.userInfo!["category"] as! [Categorylist]){
            
             NSNotificationCenter.defaultCenter().postNotificationName(
                "UpdateCategoryViewModel", object: self, userInfo: nil)
            
        }
       
    }
    
    //method to update SubCategory View model
    func updateSubCategoryList(notification : NSNotification){
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ControllerSubCategoryUpdate", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("UpdateSubCategoryViewModel", object: self, userInfo: notification.userInfo)
        
    }
    
    //method to update Search CAtegory view model
    func updateSearchCategoryList(subCategoryList : [SubCategorylist]){
        mSearchViewModelObj.updateSearchViewModel(subCategoryList)
    }

    //method to update parent categories view model
    func updateParentCategoryList(categoryList : [Categorylist]) {
        mParentCategoryVMobj.mUpdateViewModel(categoryList)
    }
    
    //method to update Parent sub category view model
    func updateParentSubCategoryList(notification : NSNotification){
        NSNotificationCenter.defaultCenter().postNotificationName("UpdateParentSubCategoryViewModel", object: self, userInfo: notification.userInfo)
         NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    func updateAvatars(notification : NSNotification){
       NSNotificationCenter.defaultCenter().postNotificationName(
        "UpdateAvatarsViewModel", object: self, userInfo: notification.userInfo)
       NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
