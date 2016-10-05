//
//  SubCategoryViewContoller.swift
//  AppyStoreApplication
//  Purpose
//  1. This class display all videos of selected category
//  2. And play video
//
//  Created by Shelly on 16/07/16.

//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ReactiveKit
import ReactiveUIKit

class SubCategoryViewContoller: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mBackButtonLabel: UIButton!
    @IBOutlet weak var mVideoButtonLabel: UIButton!
    @IBOutlet weak var mHistoryButtonLabel: UIButton!
    @IBOutlet weak var mSearchButtonLabel: UIButton!
    @IBOutlet weak var mCartButtonLabel: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    //MARK:- Local variables
    var mSubcategoryViewModelObj : SubCategoryViewModel!
    var collectionViewCell : CollectionViewCell? 
    var mCategory : Categorylist!   //to store selected category from category view
    //------------------------------
    var index : Int!
    var historyChecker = false
    
    var mVideoUrl : NSURL?
    var mCurrentIndexPath = NSIndexPath()
    
    var mSelectedCategoryCount = 0
    var offset = 0
    //------------------------------
    
    var mActivityIndicator = UIActivityIndicatorView()  //For loading
    
    //MARK:- View methods
    override func viewDidLoad() {
        
        mActivityIndicator = Utility().showActivityIndicator(mActivityIndicator,view : self.view)
        mActivityIndicator.startAnimating()
        
        //setting background for buttons
        mBackButtonLabel.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mVideoButtonLabel.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mHistoryButtonLabel.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mSearchButtonLabel.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mCartButtonLabel.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        
        //setting image for buttons
        mChangeButtonImage()
        mVideoButtonLabel.setImage(UIImage(named: "videobackground.png"), forState: UIControlState.Normal)
        super.viewDidLoad()
        
        //CollectionViewCell class registeration
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.registerNib(UINib(nibName: "CollectionHeaderReusableView", bundle: nil), forCellWithReuseIdentifier: "Header")
        
        //creating layout for cell in collection view
        collectionView.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(self.view.frame))

        
        mSubcategoryViewModelObj = SubCategoryViewModel(category: mCategory!)
        
        // setting background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        headerView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        
        headerLabel.text = mCategory.name.value
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubCategoryViewContoller.updataSubCategoryViewController(_:)), name: "UpdateSubCategoryViewController", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Collection View methods
    
    //method to return number of section in collection view
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //method to return number of item in each section of collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mSubcategoryViewModelObj.mSubcategoryList.count
    }

    //method to create collection view cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        let subCategory : SubCategorylist? = mSubcategoryViewModelObj.mGetSubCategory(indexPath.row)
        Utility().mBindCollectionViewCell(cell, subCategory: subCategory!)
        
        return cell
    }

    
    //method wil be called when item in collection view is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        mVideoUrl = NSURL(string: mSubcategoryViewModelObj.mSubcategoryList[indexPath.row].downloadUrl.value)
        mCurrentIndexPath = indexPath
        
        let LocalDB = LocalDataBase()
        LocalDB.mInsertInToHistoryTabel(mSubcategoryViewModelObj.mSubcategoryList[indexPath.row])
        
        performSegueWithIdentifier("SubCategoryToVideoPlayer", sender: nil)
        
        
    }
    //method will be called before performing segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SubCategoryToVideoPlayer"
        {
            let videoControllerObj = segue.destinationViewController as! VideoPlayerViewController
            videoControllerObj.mUrl = mVideoUrl
            videoControllerObj.mCurrentVideoIndexPath = mCurrentIndexPath
            videoControllerObj.mCategory = mCategory
            videoControllerObj.mSubcategoryViewModelObj = self.mSubcategoryViewModelObj
        }
    }

    
    @objc func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "subCategoryFooter", forIndexPath: indexPath)
        return footerView
    }
    //adding footer with Activity indicator
    func layOutWithFooter() {
        
        //creating layout for cell in collection view
        collectionView!.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(self.view.frame),view: "subCategory")
    }
    
    //removing footer from the collection view
    func layOutWithOutFooter() {
        collectionView!.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(self.view.frame),view: "subCategorywithoutFooter")
    }
    //MARK:- IBActions
    
    @IBAction func mBackButtonPressed(sender: UIButton) {
        mChangeButtonImage()
        mBackButtonLabel.setImage(UIImage(named: "backY.png"), forState: UIControlState.Normal)
        performSegueWithIdentifier("SubCategoryToCategory", sender: nil)
    }
    
    @IBAction func mVideoButtonPressed(sender: UIButton) {
        mChangeButtonImage()
        mVideoButtonLabel.setImage(UIImage(named: "videobackground.png"), forState: UIControlState.Normal)
    }
    
    @IBAction func mHistoryButtonPressed(sender: UIButton) {
        mChangeButtonImage()
        mHistoryButtonLabel.setImage(UIImage(named: "historybackground.png"), forState: UIControlState.Normal)
        performSegueWithIdentifier("SubCategoryToHistory", sender: nil)
    }
    
    @IBAction func mSearchButtonPressed(sender: UIButton) {
        mChangeButtonImage()
        mSearchButtonLabel.setImage(UIImage(named: "searchbackground.png"), forState: UIControlState.Normal)
        performSegueWithIdentifier("SubCategoryToSearch", sender: nil)
    }
    
    @IBAction func mCartButtonPressed(sender: UIButton) {
        mChangeButtonImage()
        mCartButtonLabel.setImage(UIImage(named: "cartbackground.png"), forState: UIControlState.Normal)
        
        //creating alert view
        let alertController = UIAlertController(title: "Sorry !!", message: "Cart is not available at this time", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            self.mChangeButtonImage()
            self.mVideoButtonLabel.setImage(UIImage(named: "videobackground.png"), forState: UIControlState.Normal)
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //method to change background image of buttons
    func mChangeButtonImage () {
        mBackButtonLabel.setImage(UIImage(named: "backarrow.png"), forState: UIControlState.Normal)
        mVideoButtonLabel.setImage(UIImage(named: "videoimage.png"), forState: UIControlState.Normal)
        mHistoryButtonLabel.setImage(UIImage(named: "historyimage.png"), forState: UIControlState.Normal)
        mSearchButtonLabel.setImage(UIImage(named: "searchimage.png"), forState: UIControlState.Normal)
        mCartButtonLabel.setImage(UIImage(named: "carimage.png"), forState: UIControlState.Normal)
    }

    //method to update subcategory view controller
    func updataSubCategoryViewController(notification : NSNotification) {
        
        mActivityIndicator.stopAnimating()
        let recievedCategories = mSubcategoryViewModelObj.mSubcategoryList.count
        let totalCategories = mSubcategoryViewModelObj.mTotalSubCategoryCount
        
        //for first cells in the collection view
        if recievedCategories < 21{
            collectionView?.reloadData()
        }
        //adding footer with activity indicator
        if recievedCategories < totalCategories{
            layOutWithFooter()
        }
        else{
            layOutWithOutFooter()
        }
        
    }
    
}