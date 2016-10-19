//
//  PSubCategory.swift
//  AppyStoreBLZ
//
//
//  Purpose: Providing protocols for subCategories
//
//  Created by lokesh on 17/10/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

protocol PSubCategoryViewController {
    func updataSubCategoryViewController()
}

protocol PSubCategoryViewModel {
    func updateSubCategoryViewModel(subCategoryList : [SubCategorylist])
}