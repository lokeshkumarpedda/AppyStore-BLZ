//
//  HistoryController.swift
//  AppyStoreApplication
//  Purpose
//  1. This class will get history list from controller and update it to history view controller
//
//  Created by BridgeIt on 23/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class HistoryViewModel: NSObject {

    var mHistoryList = [SubCategorylist]() //to store history deatils for view controller
    var mHistoryListCount = 0 // to store total number of history
    var mControllerObj : Controller! //create object of contoller
    var mHistoryViewControllerObj : HistoryViewController!
    
    init (historyVCObj : HistoryViewController) {
        super.init()
        mHistoryViewControllerObj = historyVCObj
        mControllerObj = Controller(historyVMObj: self)
        mGetHistoryDetails()
    }
    
    //method to get histroy details from controller
    func mGetHistoryDetails()  {
        mHistoryList = mControllerObj.mGetHistoryRecords()
        mHistoryListCount = mHistoryList.count
        updateHistoryController()
    }

    //method to update history view
    func updateHistoryController() {
        mHistoryViewControllerObj.updateHistoryViewController()
    }
}
