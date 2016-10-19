//
//  ChildDetailsViewController.swift
//  AppyStoreBLZ
//
//  Purpose :
//  For showing child details
//  NSUserDefaults to store child data
//  UIImagePicker to take pic from photo library
//
//  Created by Sumeet on 14/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//


import UIKit

class ChildDetailsViewController: UIViewController, UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate{
    //outlet of UIImageView
    @IBOutlet weak var mImageView: UIImageView!
    
    //outlet of UILabel for name
    @IBOutlet weak var mNameLabel: UILabel!
    
    //outlet of UILabel of age
    @IBOutlet weak var mAgeLabel: UILabel!
    
    //creating variable for UIImagePicker
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //calling method
        updateChildDetailsViewController()
        
        //calling method for setting imageView layout to circle
        self.setImageView()
        
        //set the delegate
        imagePicker.delegate = self
        
        //calling method for setting tap gesture
        self.setTapGesture()
        
        //setting background color to view
        self.view.backgroundColor =
            UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
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
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(ChildDetailsViewController.imageTapped))
        
        // add it to the image view;
        mImageView.addGestureRecognizer(tapGesture)
        
        // make sure imageView can be interacted with by user
        mImageView.userInteractionEnabled = true
    }
    
    //method to update childDetailsViewController
    func updateChildDetailsViewController()
    {
        //NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let object = defaults.objectForKey("childInformation")
        {
            //decoding information from NSUSERDEFAULTS
            let child = NSKeyedUnarchiver.unarchiveObjectWithData(object as! NSData) as! ChildDetails
            
            //setting child name
            mNameLabel.text = child.childName
        
            //setting child avtar pic
            if let imgObject = defaults.objectForKey("imageAvtar")
            {
                mImageView.image = UIImage(data: imgObject as! NSData)
            }
            else
            {
                let imageUrl = child.avatarUrl
                let request: NSURLRequest = NSURLRequest(URL:NSURL(string:imageUrl!)!)
                let session = NSURLSession.sharedSession()
                session.dataTaskWithRequest(request) { (data, response, error) -> Void in
                    if error == nil {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.mImageView.image = UIImage(data: data!)
                        })
                    }
                    }.resume()
            }
        
            //setting child dob
            mAgeLabel.text = String(child.age!)
        }
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
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
           let defaults = NSUserDefaults.standardUserDefaults()
            mImageView.image = pickedImage
            
            let imageData : NSData = UIImagePNGRepresentation(pickedImage)!
            defaults.setObject(imageData, forKey: "imageAvtar")
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
    
    override func shouldAutorotate() -> Bool
    {
        return true
    }
    
    @IBAction func backButton(sender: AnyObject)
    {
        navigationController?.popViewControllerAnimated(true)
    }
}
