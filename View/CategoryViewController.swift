//
//  CategoryViewController.swift
//  AppyStoreBLZ
//
//  Purpose
//  1. This class will display all category
//  2. Allow user to select any category
//
//  Created by Shelly on 04/08/16.


//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit
import Alamofire
import AlamofireImage


class CategoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,PCategoryViewController {
    //MARK:- Outlets
    @IBOutlet weak var mHomeButton: UIButton!
    @IBOutlet weak var mVideoButton: UIButton!
    @IBOutlet weak var mHistoryButton: UIButton!
    @IBOutlet weak var mSearchButton: UIButton!
    @IBOutlet weak var mCartButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    //creating objects
    var mCategoryViewModelObj : CategoryViewModel!
    var collectionViewCell : CollectionViewCell?
    //variable to to store selected category
    var mselectedCategory : Categorylist!
    var cache = AutoPurgingImageCache()
    
    var mActivityIndicator = UIActivityIndicatorView()  //For loading
    
    override func viewDidLoad() {
        mActivityIndicator = Utility().showActivityIndicator(mActivityIndicator,view : self.view)
        mActivityIndicator.startAnimating()
        
        //setting background for button
        mHomeButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mVideoButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mHistoryButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mSearchButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mCartButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        headerView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        
        //setting image for buttons
        mChangeButtonImage()
        mVideoButton.setImage(UIImage(named: "videobackground.png"), forState: UIControlState.Normal)
        
        //setting background for views
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //Registering class
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        super.viewDidLoad()
        //creating custom layout for collection view cell
        collectionView.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame) , height : CGRectGetHeight(self.view.frame))
        
        //creating object for category view model
        mCategoryViewModelObj = CategoryViewModel(obj: self)
        mCategoryViewModelObj.mGetCategories()
        
        headerLabel.text = "Main Menu"
        
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Collection View methods

    //method to return number of sections in collection view
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //method to return number of item in collection view section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mCategoryViewModelObj.mTotalCount != 0{
            mActivityIndicator.stopAnimating()
        }
        return mCategoryViewModelObj.mTotalCount
    }
    //method to return collection view cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //fetch category details
        let category : Categorylist? = mCategoryViewModelObj.mGetCategoryDetails(indexPath.row)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        let image = category?.image
        //setting layout for image view inside cell
        cell.VideoImageView.image = UIImage(named: "angry_birds_space_image_rectangular_box")
        cell.VideoImageView.layer.cornerRadius = 8
        cell.VideoImageView.clipsToBounds = true
        cell.VideoImageView.layer.borderWidth = 2
        cell.VideoImageView.layer.borderColor = UIColor.whiteColor().CGColor
        cell.VideoDurationLabel.hidden = true
        
        //activity indicator
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.color = UIColor.whiteColor()
        
        cell.VideoLabel.text = category?.name.value
        cell.imgUrl = image
        
        //checking image is in cache or not
        if let cachedImage = cache.imageWithIdentifier(image!){
            cell.VideoImageView.image = cachedImage
            cell.activityIndicator.stopAnimating()
            cell.activityIndicator.hidden = true
        }
        else{
            Alamofire.request(NSURLRequest(URL: NSURL(string: image!)!)).responseImage{
                response in
                if let img = response.result.value{
                    self.cache.addImage(img, withIdentifier: image!)
                    cell.VideoImageView.image = img
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        return cell
    }

    //method will be called when category is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        mselectedCategory = mCategoryViewModelObj.mCategoryList[indexPath.row]
        performSegueWithIdentifier("CategoryToSubCategory", sender: nil)
    }
    //method will be called before performing segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CategoryToSubCategory" {
            let subCategoryViewControllerObj = segue.destinationViewController as! SubCategoryViewContoller
            subCategoryViewControllerObj.mCategory = mselectedCategory
        }
    }

    //method to update category view contrller
    func updateCategoryViewController() {
        
        if mCategoryViewModelObj.mTotalCount == 0 {
            mCategoryViewModelObj.mGetCategories()
        }
        mActivityIndicator.stopAnimating()
        collectionView.reloadData()
        
    }
    //method to set image for buttons
    func mChangeButtonImage() {
        mHomeButton.setImage(UIImage(named: "ladyimage"), forState: UIControlState.Normal)
        mVideoButton.setImage(UIImage(named: "videoimage"), forState: UIControlState.Normal)
        mHistoryButton.setImage(UIImage(named: "historyimage"), forState: UIControlState.Normal)
        mSearchButton.setImage(UIImage(named: "searchimage"), forState: UIControlState.Normal)
        mCartButton.setImage(UIImage(named: "carimage"), forState: UIControlState.Normal)
    }
    //MARK:- IBActions
    @IBAction func mHomeButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("CategoryToHome", sender: nil)
    }
    
    @IBAction func mVideoButtonPressed(sender: UIButton) {
    }
    
    @IBAction func mHistoryButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("CategoryToHistory", sender: nil)
    }
    
    @IBAction func mSearchButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("CategoryToSearch", sender: nil)
    }
    
    @IBAction func mCartButtonPressed(sender: UIButton) {
        mChangeButtonImage()
        mCartButton.setImage(UIImage(named: "cartbackground.png"), forState: UIControlState.Normal)
        
        //creating alert view
        let alertController = UIAlertController(title: "Sorry !!", message: "Cart is not available at this time", preferredStyle: UIAlertControllerStyle.Alert)

        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print("OK")
            
            self.mChangeButtonImage()
            self.mVideoButton.setImage(UIImage(named: "videobackground.png"), forState: UIControlState.Normal)
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //comming back from the parenting area
    @IBAction func backToCategoryVC(unwindSegue : UIStoryboardSegue){
        
    }
}
