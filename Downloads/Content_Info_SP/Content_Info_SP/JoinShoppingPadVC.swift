//
//  JoinShoppingPadVC.swift
//  TestSP
//
//  Created by Vidya Ramamurthy on 21/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit



class JoinShoppingPadVC: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var AddBackgroundOutlet: UIButton!
    
    @IBOutlet weak var addProfilePhotoOutlet: UIButton!
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    //textFields outlet
    @IBOutlet weak var NicknameTextField: UITextField!
    
    @IBOutlet weak var EmailTextFieldOutlet: UITextField!
    
    @IBOutlet weak var PsswordTextFieldOutlet: UITextField!
    
    
    //code for picking up the image from gallary
    let imagePicker = UIImagePickerController()
    let imagePicker1 = UIImagePickerController()
    var ImagePicked = 0
    
    @IBAction func addBackGround(sender: AnyObject)
    {
        // change in code
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        ImagePicked = 0
        AddBackgroundOutlet.setTitle("change photo", forState: UIControlState.Normal)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if (ImagePicked == 0)
            {
            //showImage.frame = CGRectMake(13,70,294,144)
                
            //var newim = cropToBounds(pickedImage, width: 382 , height: 202)

            showImage.clipsToBounds = true
            //showImage.contentMode = .ScaleAspectFit
                
                
                
            showImage.image = pickedImage
                
            //imageView.contentMode = UIViewContentMode.ScaleAspectFit
                //showImage.contentMode = UIViewContentMode.ScaleAspectFit
            }
            if (ImagePicked == 1)
            {
        
                profilePhoto.layer.borderWidth = 1.0
                profilePhoto.layer.masksToBounds = false
                profilePhoto.layer.borderColor = UIColor.whiteColor().CGColor
                profilePhoto.layer.cornerRadius = profilePhoto.frame.size.width/2
                profilePhoto.clipsToBounds = true
                profilePhoto.image = pickedImage
                
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if(segue.identifier == "logInSegue")
            {
            }
       }
    
    
       
    
    @IBAction func addProfilePhotoBttn(sender: AnyObject) {
        ImagePicked = 1
        
        
        imagePicker1.allowsEditing = false
        imagePicker1.sourceType = .PhotoLibrary
        presentViewController(imagePicker1, animated: true, completion: nil)
        addProfilePhotoOutlet.setTitle("change photo", forState: UIControlState.Normal)
        
    }
    // code for cropping image
    
    var path : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker1.delegate = self
        
        NicknameTextField.backgroundColor = UIColor.blackColor()
        NicknameTextField.attributedPlaceholder = NSAttributedString(string: "Your Name", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        
        EmailTextFieldOutlet.backgroundColor = UIColor.blackColor()
        EmailTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Your Email", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        
        PsswordTextFieldOutlet.backgroundColor = UIColor.blackColor()
        PsswordTextFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Your Password", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        
        //code for changing navigation bar text color
        
               
        navigationController?.navigationBar.barTintColor = UIColor.blackColor() // Bar's background color
        navigationController?.navigationBar.tintColor = UIColor.grayColor()     //back button color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.grayColor()] //title's text color
        
        
         path = userModel().createTable()
        print ("path in main" , path)

        // Do view setup here.
    }
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        print("path in sign in " , path)
        let userName : String = EmailTextFieldOutlet.text! as String
        let password : String = PsswordTextFieldOutlet.text! as String
        
        userModel().saveData(path!, userName: userName, password: password)
    }
    
    


}
