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
    var totalCOunt : Int
    
    init(name : String,image : String,cId : Int,pId : Int,totalCount : Int){
        self.name = Observable(name)
        self.image = image
        self.categoryId = cId
        self.parentId = pId
        self.totalCOunt = totalCount
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
    
    init(title : String,duration : String,downloadUrl : String,imageUrl : String,totalCount : Int){
        self.title = Observable(title)
        self.duration = Observable(duration)
        self.downloadUrl = Observable(downloadUrl)
        self.imageUrl = imageUrl
        self.totalCount = totalCount
    }
}

//structure to store child details
class ChildDetails
{
    var name : String
    var childId : String
    var userId : String
    var type : String
    var dob : String
    var avtarId : String
    var avtarImg : String
    
    init(name : String,cId : String,uId :String,type : String,dob : String, avtarId : String,avtarImg :String)
    {
        self.name = name
        self.childId = cId
        self.userId = uId
        self.type = type
        self.dob = dob
        self.avtarId = avtarId
        self.avtarImg = avtarImg
    }
}