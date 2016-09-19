//
//  AvatarListModel.swift
//  AppyStoreBLZ
//
//  Created by Lokesh Kumar on 18/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

//Structure to store avatar details
class Avatar {
    var avatarId : Int
    var avatarUrl : String?
    
    init(id: Int , url: String){
        self.avatarId = id
        self.avatarUrl = url
    }
}
