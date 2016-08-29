//
//  SearchController.swift
//  AppyStoreApplication
//  Purpose 
//  1. This class get search key word from search view controller 
//  2. And get search reasults from controller and update it to search view controller
//
//  Created by Shelly on 23/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit



class SearchViewMode: PSearchViewModel {
    
    var mControllerObj : Controller!
    var mSearchList = [SubCategorylist]()
    var mTotalSearchCategory = 0 //varibale to store total number of categories
    var mReceivedCategoryCount = 0 //variable to store no of received categories
    var mSearchViewControllerObj : PSearchViewController!
    
    init(searchVCObj : PSearchViewController) {
        mSearchViewControllerObj = searchVCObj
        mControllerObj = Controller(searchViewMode: self)
    }
    
    //method to fetch search category from controller
    func mFetchSearchCategoryDetailsFromController (keyWord : String) {
        //calling controller to get search category
        mControllerObj.mGetSearchCategory(keyWord)
    }
    
    //method to give search category
    func mGetSearchCategory(index : Int) -> SubCategorylist? {
        //if index is available in searchlist
        if index < mSearchList.count {
            return mSearchList[index]
        }
        //index is not available in searchlist
        else {
            if index%8 == 0 {
                //mFetchSubCategoryDetailsFromController(mCategory.categoryId, p_Id: mCategory.parentId, offSet: index)
            }
            //creating dummy data
            let category = SubCategorylist(title: "", duration: "", downloadUrl: "", imageUrl: "", totalCount: index)
            //inserting dummy content into search list
            mSearchList.insert(category, atIndex: index)
            return mSearchList[index]
        }
    }
    
    //method to update search view controller
    func updateSearchViewModel(subCategoryList : [SubCategorylist]) {

        //adding content to list
        for category in subCategoryList {
            mTotalSearchCategory = subCategoryList[0].totalCount
            //if search result don't have dummy value
            if mReceivedCategoryCount < mSearchList.count {
                mSearchList[mReceivedCategoryCount] = category
            }
            //if search list contain dummy value
            else {
                mSearchList.insert(category, atIndex: mReceivedCategoryCount)
            }
            mReceivedCategoryCount += 1
        }

        mSearchViewControllerObj.updateSearchViewController()
    }
    
    

}
