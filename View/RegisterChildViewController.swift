//
//  RegisterChildViewController.swift
//  AppyStoreBLZ
//
//  Purpose : Taking the child name and date of birth
//
//  Created by BridgeLabz on 17/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class RegisterChildViewController: UIViewController {

    @IBOutlet weak var mNameTxtFld: UITextField!
    @IBOutlet weak var mDatePicker: UIDatePicker!
    
    
    var mActivityIndicator = UIActivityIndicatorView()  //For loading
    
    var mSelectedAvatar : Int?
    
    //when view loaded
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        mActivityIndicator = Utility().showActivityIndicator(mActivityIndicator,view : self.view)
        //putting datepicker maximum date to current date
        mDatePicker.maximumDate = mDatePicker.date
        
        //observer for registration success
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: #selector(registrationSuccessful(_:)), name: "RegistrationSuccess", object: nil)
        
        //observer registration failure
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: #selector(invalidChildName(_:)), name: "RegistrationFailed", object: nil)
    }
    
    //method to dismiss keyboard when return button pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        mNameTxtFld.resignFirstResponder()
        return true
    }
    
    @IBAction func registrationButton(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //checking the texfield is empty or not
        let text = mNameTxtFld.text!
        if text.characters.count != 0{
            mActivityIndicator.startAnimating()
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            let date = dateFormater.stringFromDate(mDatePicker.date)
            Controller().mRegisterChildDetails(text, dob: date, avatarId: mSelectedAvatar!)

            //removing object
            defaults.removeObjectForKey("imageAvtar")

        }
        else{
            //creating alert view
            let alertController = UIAlertController(title: "Invalid Name", message: "Enter the name", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    //when registration is completed
    func registrationSuccessful(notification : NSNotification){
        mActivityIndicator.stopAnimating()
        
        //creating alert view
        let alertController = UIAlertController(title: "Successful", message: "Child Registered", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //showing the message that name is already exists
    func invalidChildName(notification : NSNotification){
        mActivityIndicator.stopAnimating()
        //creating alert view
        let alertController = UIAlertController(title: "Invalid Name", message: "Child Name already exists", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //For going back to previous view controller
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}
