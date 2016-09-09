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
        }else{
            playListSetUpLayout(width, h: height)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout (w : CGFloat ,h : CGFloat) {
        minimumInteritemSpacing = 3
        minimumLineSpacing = 20
        itemSize = CGSize(width: (w-65)/4, height: (h-130)/2)
        sectionInset = UIEdgeInsetsMake(20,10,10,10)
        scrollDirection = .Vertical
        
    }
    //For video player play list
    func playListSetUpLayout(w: CGFloat, h: CGFloat){
        minimumInteritemSpacing = 3
        minimumLineSpacing = 20
        itemSize = CGSize(width: (w-65)/4, height: h)
        sectionInset = UIEdgeInsetsMake(20,10,10,10)
        scrollDirection = .Horizontal
    }
    
    //For parents area
    func parentAreaLayout(w: CGFloat, h: CGFloat){
        minimumInteritemSpacing = 3
        minimumLineSpacing = 20
        itemSize = CGSize(width: (w-65)/3, height: (h-130)/2)
        sectionInset = UIEdgeInsetsMake(20,10,10,10)
        scrollDirection = .Vertical
    }
}
