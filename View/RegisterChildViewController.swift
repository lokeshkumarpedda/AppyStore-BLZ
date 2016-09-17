//
//  RegisterChildViewController.swift
//  AppyStoreBLZ
//
//  Created by BridgeLabz on 17/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class RegisterChildViewController: UIViewController {

    @IBOutlet weak var mNameTxtFld: UITextField!
    
    @IBOutlet weak var mDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        mDatePicker.maximumDate = mDatePicker.date
    }
    
    @IBAction func nextButton(sender: AnyObject) {
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
    
}
