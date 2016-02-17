//
//  SignInViewController.swift
//  TestSP
//
//  Created by Vidya Ramamurthy on 21/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var backGroundLabel: UILabel!
    @IBOutlet weak var userPWTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
       let backLabel = UILabel(frame: CGRectMake(20, 108, 269, 138))
        
        if((userEmailTextField.text! == "")||(userPWTextField.text! == ""))
        {
            //Create Lable Programatically
       
            
            backLabel.text = ""
            backLabel.textAlignment = NSTextAlignment.Center
            backLabel.textColor = UIColor.whiteColor()
            backLabel.numberOfLines = 0
            backLabel.text = "YOUR EMAIL OR PASSWORD WAS ENTERED INCORRECTLY"
            backLabel.backgroundColor = UIColor.redColor()
            self.view.addSubview(backLabel)
            twitterButton.enabled = false
            facebookButton.enabled = false
            googleButton.enabled = false
            //backLabel.text = ""
            
        }
        
    }
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userPWTextField.secureTextEntry = true
            }
    
}
