//
//  ViewController.swift
//  sp_1
//
//  Created by BridgeLabz on 21/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class HomeScreen: UIViewController {
    // imageView
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var marketImageView: UIImageView!
    @IBOutlet weak var shopperImageView: UIImageView!
    
    @IBOutlet weak var AnalyticsImageView: UIImageView!
    
    
    //Login Buttons Outlrt
   
    
    @IBOutlet weak var signUpWithEmailOutlet: UIButton!
    
    @IBOutlet weak var coonectWthFBoutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
                
//        set imageView attributes
        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.blackColor().CGColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
        //market button
        marketImageView.layer.borderWidth = 1
        marketImageView.layer.masksToBounds = false
        marketImageView.layer.borderColor = UIColor.blackColor().CGColor
        marketImageView.layer.cornerRadius = image.frame.height/2
        marketImageView.clipsToBounds = true
        
        //shopper Button
        shopperImageView.layer.borderWidth = 1
        shopperImageView.layer.masksToBounds = false
        shopperImageView.layer.borderColor = UIColor.blackColor().CGColor
        shopperImageView.layer.cornerRadius = image.frame.height/2
        shopperImageView.clipsToBounds = true
        
        //analytics Button
        AnalyticsImageView.layer.borderWidth = 1
        AnalyticsImageView.layer.masksToBounds = false
        AnalyticsImageView.layer.borderColor = UIColor.blackColor().CGColor
        AnalyticsImageView.layer.cornerRadius = image.frame.height/2
        AnalyticsImageView.clipsToBounds = true
        
        //Set border of buttons
        signUpWithEmailOutlet.layer.borderWidth = 1
        signUpWithEmailOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        
        coonectWthFBoutlet.layer.borderWidth = 1
        coonectWthFBoutlet.layer.borderColor = UIColor.whiteColor().CGColor
      
    
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

