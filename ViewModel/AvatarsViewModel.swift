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

class AvatarsViewModel: NSObject ,PAvatarViewModel{
    
    var mAvatarList = [Avatar]()  //creating array of Avatar list
    var mControllerObj : Controller!    //creating controller reference
    var mTotalCount = 0
    var mAvatarVCObj : PAvatarViewController! //creating controller protocol object
    
    init(obj : PAvatarViewController){
        super.init()
        mAvatarVCObj = obj
        mControllerObj = Controller(avatarVMObj: self)
        mControllerObj!.mGetAvatars()
    }
    
    //updating view model
    func updateAvatarsViewModel(avatarList: [Avatar]){
        mAvatarList = avatarList
        mTotalCount = mAvatarList.count
        mAvatarVCObj.updateAvatarVC()
        
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