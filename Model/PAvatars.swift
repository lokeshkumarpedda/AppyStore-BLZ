//
//  PAvatars.swift
//  AppyStoreBLZ
//
//
//  Purpose: Providing protocols for Avatars
//
//  Created by lokesh on 17/10/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

protocol PAvatarViewController {
    func updateAvatarVC()
}

protocol PAvatarViewModel {
    func updateAvatarsViewModel(avatarList: [Avatar])
}