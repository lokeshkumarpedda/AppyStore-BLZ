//
//  firstView.swift
//  sp_1
//
//  Created by BridgeLabz on 21/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import Darwin

class firstView: UIView {
    
    
       override func drawRect(rect: CGRect) {
        
        //set background image
        
        let myImage = UIImage(named: "back.png")
        let imageRect = UIScreen.mainScreen().bounds
        myImage?.drawInRect(imageRect)

        

    }
    
    
    
}

