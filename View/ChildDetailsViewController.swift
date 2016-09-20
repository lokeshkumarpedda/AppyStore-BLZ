//
//  ChildDetailsViewController.swift
//  AppyStoreBLZ
//
//  Purpose :
//  For showing child details
//
//  Created by Sumeet on 14/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class ChildDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var mNameLabel: UILabel!
    
    @IBOutlet weak var mAgeLabel: UILabel!
    
    //creating variable for UIImagePicker
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateChildDetailsViewController()
        //calling method for setting imageView layout
        self.setImageView()
        
        //set the delegate
        imagePicker.delegate = self
        
        //calling method for setting tap gesture
        self.setTapGesture()
        
        //setting background color to view
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
    }
    
    //handling low memory warning
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //setting imageview layout to circle
    func setImageView()
    {
        mImageView.layer.borderWidth = 1
        mImageView.layer.masksToBounds = false
        mImageView.layer.borderColor = UIColor.clearColor().CGColor
        mImageView.layer.cornerRadius = mImageView.frame.height/2
        mImageView.clipsToBounds = true
    }
    
    //setting tap gesture
    func setTapGesture()
    {
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChildDetailsViewController.imageTapped))
        
        // add it to the image view;
        mImageView.addGestureRecognizer(tapGesture)
        
        // make sure imageView can be interacted with by user
        mImageView.userInteractionEnabled = true
    }
    
    //method to update childDetailsViewController
    func updateChildDetailsViewController()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let object = defaults.objectForKey("childInformation"){
            //decoding information from NSUSERDEFAULTS
            let child = NSKeyedUnarchiver.unarchiveObjectWithData(object as! NSData) as! ChildDetails
            
            //setting child name
            mNameLabel.text = child.childName
        
            //setting child avtar pic
            let imageUrl = child.avatarUrl
            mImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string:imageUrl!)!)!)
        
            //setting child dob
            mAgeLabel.text = String(child.age!)
        }
        else{
            //creating alert view
            let alertController = UIAlertController(title: "Register A child", message: "Please register a child", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //calculating age
    func calculateAge (birthday: NSDate) -> Int
    {
        return NSCalendar.currentCalendar().components(.Year, fromDate: birthday, toDate: NSDate() , options: [] ).year
    }
    
    // MARK: tap gesture
    
    // on tap of child's profile pic
    func  imageTapped(gesture: UIGestureRecognizer)
    {
        if (gesture.view as? UIImageView) != nil
        {
            imagePicker.allowsEditing = true
            //selecting source type as photo library
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.modalPresentationStyle = .Custom
            
            //adding image picker to view controller
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    //getting selected image from photo library
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            //mImageView.contentMode = .ScaleAspectFit
            mImageView.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //when cancel image picker
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
