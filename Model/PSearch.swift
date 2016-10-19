//
//  PSearch.swift
//  AppyStoreBLZ
//
//
//  Purpose: Providing protocols for search
//
//  Created by Lokesh on 17/10/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

protocol PSearchViewController {
    func updateSearchViewController()
    func cellReloading()
}


protocol PSearchViewModel {
    func updateSearchViewModel(subCategoryList : [SubCategorylist])
}

