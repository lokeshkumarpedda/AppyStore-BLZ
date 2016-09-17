//
//  CustomViewFlowLayout.swift
//  AppyStoreApplication
//  Purpose
//  1. This class is responsible for display layout of collection view for all view controllers
//  2. This class set collection view cell height, width and all layout related to collection view cell
//
//  Created by Shelly on 26/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class CustomViewFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
    }
    
    init(width : CGFloat ,height : CGFloat) {
        super.init()
        setUpLayout(width,h: height)
    }
    
    init(width : CGFloat, height : CGFloat, view : String) {
        super.init()
        
        if view == "parentArea"{
            
            parentAreaLayout(width, h: height)
            
        }else if view == "videoPlayer"{
            
            playListSetUpLayout(width, h: height,view: view)
            
        }else if view == "videoPlayerWithFooter"{
            
            playListSetUpLayout(width, h: height,view: view)
            
        }
        else if view == "subCategory"{
            
            subCategoryLayoutWithFooter(width,h: height)
            
        }else if view == "parentSubCategory"{
            
            subCategoryLayoutWithFooter(width, h: height)
            
        }
        else {
            
            subCategoryLayOutWithOutFooter(width, h: height)
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    func setUpLayout (w : CGFloat ,h : CGFloat) {
        minimumInteritemSpacing = 3
        minimumLineSpacing = 20
        itemSize = CGSize(width: (w-65)/4, height: (h-130)/2)
        sectionInset = UIEdgeInsetsMake(20,10,10,10)
        scrollDirection = .Vertical
        footerReferenceSize = CGSize(width: 0, height: 0)
        
    }
    //For video player play list
    func playListSetUpLayout(w: CGFloat, h: CGFloat, view: String){
        minimumInteritemSpacing = 3
        minimumLineSpacing = 20
        itemSize = CGSize(width: (w-65)/4, height: h)
        sectionInset = UIEdgeInsetsMake(20,10,10,10)
        scrollDirection = .Horizontal
        if view == "videoPlayer"{
            footerReferenceSize = CGSize(width: 0, height: 0)
        }
        else{
            footerReferenceSize = CGSize(width: (w-65)/3, height: h)
        }
    }
    
    //For parents area
    func parentAreaLayout(w: CGFloat, h: CGFloat){
        minimumInteritemSpacing = 3
        minimumLineSpacing = 20
        itemSize = CGSize(width: (w-65)/3, height: (h-130)/2)
        sectionInset = UIEdgeInsetsMake(20,10,10,10)
        scrollDirection = .Vertical
    }
    
    //with footer
    func subCategoryLayoutWithFooter (w : CGFloat ,h : CGFloat) {
        minimumInteritemSpacing = 3
        minimumLineSpacing = 20
        itemSize = CGSize(width: (w-65)/4, height: (h-130)/2)
        sectionInset = UIEdgeInsetsMake(20,10,10,10)
        scrollDirection = .Vertical
        footerReferenceSize = CGSize(width: w, height: (h-130)/2)
    }
    
    //without footer
    func subCategoryLayOutWithOutFooter(w : CGFloat ,h : CGFloat){
        minimumInteritemSpacing = 3
        minimumLineSpacing = 20
        itemSize = CGSize(width: (w-65)/4, height: (h-130)/2)
        sectionInset = UIEdgeInsetsMake(20,10,10,10)
        scrollDirection = .Vertical
        footerReferenceSize = CGSize(width: 0, height: 0)
        
    }
}
