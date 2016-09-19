//
//  AvatarsViewModel.swift
//  AppyStoreBLZ
//
//  Purpose : Display the avatars
//
//  Created by Lokesh Kumar on 18/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class AvatarsViewModel: NSObject {
    
    var mAvatarList = [Avatar]()  //creating array of Avatar list
    var mControllerObj : Controller!    //creating controller reference
    var mTotalCount = 0
    
    override init(){
        super.init()
        mControllerObj = Controller()
        mControllerObj!.mGetAvatars()
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: #selector(updateAvatarsViewModel(_:)), name: "UpdateAvatarsViewModel", object: nil)
    }
    
    //updating view model
    func updateAvatarsViewModel(notification : NSNotification){
        mAvatarList = notification.userInfo!["Avatars"] as! [Avatar]
        mTotalCount = mAvatarList.count
        NSNotificationCenter.defaultCenter()
            .postNotificationName("UpdateAvatarsViewController", object: nil)
        
    }
    
    //giving total cells to view controller
    func getCellsCount() -> Int {
        return mTotalCount
    }
    
    //giving avatar details to view controller
    func getAvatar(index: Int) -> Avatar {
        return mAvatarList[index]
    }
}