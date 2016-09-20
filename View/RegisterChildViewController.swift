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
    let mActivityIndicatorContainer = UIView()          //For activity indicator display
    
    var mSelectedAvatar : Int?
    
    //when view loaded
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //putting datepicker maximum date to current date
        mDatePicker.maximumDate = mDatePicker.date
        
        //observer for registration success
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: #selector(registrationSuccessful(_:)), name: "RegistrationSuccess", object: nil)
        
        //observer registration failure
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: #selector(invalidChildName(_:)), name: "RegistrationFailed", object: nil)
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        
        //checking the texfield is empty or not
        let text = mNameTxtFld.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if text.characters.count != 0{
            showActivityIndicator()
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            let date = dateFormater.stringFromDate(mDatePicker.date)
            Controller().mRegisterChildDetails(text, dob: date, avatarId: mSelectedAvatar!)
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
        stopActivityIndicator()
        
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
        stopActivityIndicator()
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
    
    //MARK: Activity indicator methods
    
    //For activity indicator display and animation
    func showActivityIndicator(){
        
        //customizing container for activity indicator
        mActivityIndicatorContainer.frame = CGRectMake(0, 0, 40, 40)
        mActivityIndicatorContainer.center = view.center
        mActivityIndicatorContainer.backgroundColor = UIColor.darkGrayColor()
        mActivityIndicatorContainer.layer.cornerRadius = 10
        
        //customizing activity indicator
        mActivityIndicator.frame = CGRectMake(0, 0, 40, 40)
        mActivityIndicator.activityIndicatorViewStyle = .White
        mActivityIndicator.clipsToBounds = true
        mActivityIndicator.hidesWhenStopped = true
        
        //Adding activity indicator to particular view
        mActivityIndicatorContainer.addSubview(mActivityIndicator)
        view.addSubview(mActivityIndicatorContainer)
        
        //Starting the the animation
        mActivityIndicator.startAnimating()
    }
    
    //For stop displaying the activity indicator
    func stopActivityIndicator() {
        
        mActivityIndicator.stopAnimating()
        
        //removing from the screen
        mActivityIndicatorContainer.removeFromSuperview()
    }
}
