//
//  LoginViewController.swift
//  AppyStoreBLZ
//  Purpose
//  1 . This is login page
//  2 . User can enter their registered mobile no for login
//  3 . User can login without registeration also
//
//  Created by Shelly on 09/08/16.


//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var MobileNoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //to dismiss keyboard 
        MobileNoTextField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
    }
    
    func  dismissKeyboard() {
        MobileNoTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        MobileNoTextField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginInWithMobileNoButton(sender: UIButton) {
    }

    @IBAction func LoginInWithOutMobileNoButton(sender: UIButton) {
        performSegueWithIdentifier("LoginToCategory", sender: nil)
    }

}
