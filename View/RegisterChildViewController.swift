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
    
    //when view loaded
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //putting datepicker maximum date to current date
        mDatePicker.maximumDate = mDatePicker.date
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        
        //checking the texfield is empty or not
        if mNameTxtFld.text?.characters.count != 0{
            
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            let date = dateFormater.stringFromDate(mDatePicker.date)
            print(date)
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
    
    //For going back to previous view controller
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
