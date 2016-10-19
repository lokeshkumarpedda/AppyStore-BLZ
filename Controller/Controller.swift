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
    //MARK:- Objects
    var mApiRequesrObj = ApiRequest() //create object to make rest call
    var mLocalDataBaseObj = LocalDataBase() //object of local database
    var mCategoryViewModelObj : PCategoryViewModel! //object od category view model
    var mSubCategoryViewModelObj : PSubCategoryViewModel!
                                            //object of sub category view model
    var mSearchViewModelObj : PSearchViewModel! //object of search view model
    var mHistoryViewModel : HistoryViewModel! //object of history view model
    var mParentCategoryVMobj : PCategoryViewModel! //object of parent category view model
    var mparentSubcategoryVMObj :PSubCategoryViewModel!//object of parent subcategry veiw model
    var mAvatarVMObj : PAvatarViewModel!//object of Avatar view model
    
    override init() {
        super.init()
    }
    
    //init for categories
    init(categoryVMObj : PCategoryViewModel) {
        mCategoryViewModelObj = categoryVMObj
    }
    
    //init for subcategories
    init(subCategoryVMObj : PSubCategoryViewModel) {
        mSubCategoryViewModelObj = subCategoryVMObj
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
    init(parentCategoryVMobj : PCategoryViewModel) {
        mParentCategoryVMobj = parentCategoryVMobj
    }
    
    //init for parent subcategories
    init(parentSubcategoryVMObj : PSubCategoryViewModel) {
        mparentSubcategoryVMObj = parentSubcategoryVMObj
    }
    
    //init for avatars
    init(avatarVMObj : PAvatarViewModel) {
        mAvatarVMObj = avatarVMObj
    }
    
    //MARK:- Fetch details methods
    //method to get category list from rest api
    func mGetCategoryDetails() -> [Categorylist]{
        let categoryDetails = mLocalDataBaseObj.mFetchCategoryDetails()
        mApiRequesrObj.mFetchCategoryList(self)
        
        return categoryDetails
    }
    
    //method to get subcategory from rest api
    func mGetSubCategoryDetails(cId : Int,pId : Int,offSet : Int) {
        mApiRequesrObj.mFetchSubCategoryList(self,c_Id: cId,p_Id : pId,offset: offSet)
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
        mApiRequesrObj.mFetchSubParentingCategories(self,
                                                    c_Id: cId,
                                                    p_Id : pId,
                                                    offset: offSet)
        
    }
    
    //method to get avatar list
    func mGetAvatars() {
        mApiRequesrObj.mFetchAvatarList(self)
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
    func updateCategoryDetails(categories: [Categorylist]){
        if mLocalDataBaseObj.mCheckCategoryUpdates(categories){
             mCategoryViewModelObj.updateCategoryViewModel(categories)
        }
       
    }
    
    //method to update SubCategory View model
    func updateSubCategoryList(subCategories : [SubCategorylist]){
        
        mSubCategoryViewModelObj.updateSubCategoryViewModel(subCategories)
        
    }
    
    //method to update Search CAtegory view model
    func updateSearchCategoryList(subCategoryList : [SubCategorylist]){
        mSearchViewModelObj.updateSearchViewModel(subCategoryList)
    }

    //method to update parent categories view model
    func updateParentCategoryList(categoryList : [Categorylist]) {
        mParentCategoryVMobj.updateCategoryViewModel(categoryList)
    }
    
    //method to update Parent sub category view model
    func updateParentSubCategoryList(subCategories : [SubCategorylist]){
        mparentSubcategoryVMObj.updateSubCategoryViewModel(subCategories)
    }
    
    //method to update avatar view model
    func updateAvatars(avatars: [Avatar]){
        mAvatarVMObj.updateAvatarsViewModel(avatars)
    }
}
