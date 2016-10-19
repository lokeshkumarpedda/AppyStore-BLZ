//
//  CategoryDetails.swift
//  AppyStoreBLZ
//
//  Created by Shelly on 01/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import ReactiveKit


//structure to store category details
class Categorylist {
    var name : Observable<String>
    var image : String
    var categoryId : Int
    var parentId : Int
    var totalCount : Int
    
    init(name : String,image : String,cId : Int,pId : Int,totalCount : Int){
        self.name = Observable(name)
        self.image = image
        self.categoryId = cId
        self.parentId = pId
        self.totalCount = totalCount
    }
}

//structure to store subcategory details
class SubCategorylist {
    var title : Observable<String>
//    var image : ObservableBuffer<UIImage>?
    var duration : Observable<String>
    var downloadUrl : Observable<String>
    var imageUrl : String?
    var totalCount : Int
    
    init(title : String,
         duration : String,
         downloadUrl : String,
         imageUrl : String,
         totalCount : Int){
        
        self.title = Observable(title)
        self.duration = Observable(duration)
        self.downloadUrl = Observable(downloadUrl)
        self.imageUrl = imageUrl
        self.totalCount = totalCount
    }
}