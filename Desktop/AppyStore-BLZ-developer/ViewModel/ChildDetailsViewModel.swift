//
//  ChildDetailsViewModel.swift
//  AppyStoreBLZ
//
//  Purpose :
//  Passing child id to get child response
//
//  Created by Sumeet on 14/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class ChildDetailsViewModel: NSObject
{
    //object of Controller
    var mControllerObj : Controller!
    
    override init()
    {
        super.init()
        //calling method
        mFetchChildDetailsFromController()
    }

    //method to fetch child details from controller
    func mFetchChildDetailsFromController()
    {
        mControllerObj = Controller()
        mControllerObj!.mGetChildDetailsFromRest(3253)
    }
}
