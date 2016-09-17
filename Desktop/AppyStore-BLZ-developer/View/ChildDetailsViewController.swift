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

class ChildDetailsViewController: UIViewController
{
    // outlet of UIScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    //outlet of UIImageView
    @IBOutlet weak var mImageView: UIImageView!
    
    //outlet of name label
    @IBOutlet weak var mNameLabel: UILabel!
    
    //outlet of age label
    @IBOutlet weak var mAgeLabel: UILabel!
   
    //object of ChildDetailsViewModel
    var mChildDetailsViewModelObj : ChildDetailsViewModel?
    
    //variable to store Child Details
    var mChild = [ChildDetails]()
    
    let activityIndicator = UIActivityIndicatorView()
    let activityIndicatorContainer = UIView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //setting background color to view
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //setting scrollView
        scrollView.contentSize = CGSizeMake(scrollView.frame.width, scrollView.frame.height)
        
        mChildDetailsViewModelObj = ChildDetailsViewModel()
        
        //notification observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChildDetailsViewController.updateChildDetailsViewController(_:)), name: "updateChildDetailsViewController", object: nil)
        showActivityIndicator()
        
    }

    //method to update childDetailsViewController
    func updateChildDetailsViewController(notification : NSNotification)
    {
        stopActivityIndicator()
        
        //getting child detail
        mChild = notification.userInfo!["child"] as! [ChildDetails]
        
        //setting child name
        mNameLabel.text = mChild[0].name
        
        //setting child avtar pic
        let imageUrl = mChild[0].avtarImg
        mImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string:imageUrl)!)!)
        
        //converting dob string to NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(mChild[0].dob)
        
        //calling function to calculate age
        let age = calculateAge(date!)
        
        //setting child dob
        mAgeLabel.text = String(age)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //calculating age
    func calculateAge (birthday: NSDate) -> Int
    {
        return NSCalendar.currentCalendar().components(.Year, fromDate: birthday, toDate: NSDate() , options: [] ).year
    }
    
    //MARK: activity indicator methods
    
    //For activity indicator display and animation
    func showActivityIndicator(){
        
        activityIndicatorContainer.frame = CGRectMake(0, 0, 40, 40)
        activityIndicatorContainer.center = view.center
        activityIndicatorContainer.backgroundColor = UIColor.darkGrayColor()
        activityIndicatorContainer.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
        activityIndicator.activityIndicatorViewStyle = .White
        activityIndicator.clipsToBounds = true
        activityIndicator.hidesWhenStopped = true
        
        //Adding activity indicator to particular view
        activityIndicatorContainer.addSubview(activityIndicator)
        view.addSubview(activityIndicatorContainer)
        
        //Staring the the animation
        activityIndicator.startAnimating()
        
    }
    
    //For stop displaying the activity indicator
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicatorContainer.removeFromSuperview()
    }
    

}
