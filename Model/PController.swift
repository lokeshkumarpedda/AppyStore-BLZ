

//
//  PController.swift
//  AppyStoreBLZ
//
//  Created by Shelly on 07/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//


protocol PController {
    
    func updateCategoryDetails(categories: [Categorylist])
    
    func updateSubCategoryList(subCategories : [SubCategorylist])
    
    func updateSearchCategoryList(subCategoryList : [SubCategorylist])
    
    func updateParentCategoryList(categoryList : [Categorylist])
    
    func updateParentSubCategoryList(subCategories : [SubCategorylist])
    
    func updateAvatars(avatars: [Avatar])
}
