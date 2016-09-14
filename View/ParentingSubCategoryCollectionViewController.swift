//
//  ParentingSubCategoryCollectionViewController.swift
//  AppyStoreBLZ
//
//  Purpose:
//  For Displaying parenting sub categories videos
//
//  Created by Lokesh Kumar on 10/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

private let reuseIdentifier = "CollectionViewCell"

class ParentingSubCategoryCollectionViewController: UICollectionViewController {

    var mParentSubcategoryViewModelObj : ParentingSubcategoryViewModel!//viewmodel object
    var mParentCategory : Categorylist!   //to store selected category from category view
    
    var mAvPlayer = AVPlayer()
    var mAvPlayerViewController = AVPlayerViewController()
    
    var mActivityIndicator = UIActivityIndicatorView()  //For loading
    let mActivityIndicatorContainer = UIView()          //For activity indicator display
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for displaying the activity indicator
        showActivityIndicator()
        self.navigationItem.title = mParentCategory.name.value
        mParentSubcategoryViewModelObj = ParentingSubcategoryViewModel(parentingSubCategory: mParentCategory!)
        
        //setting the background
        collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //CollectionViewCell class registeration
        collectionView!.registerNib(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        //creating layout for cell in collection view
        layOutWithOutFooter()
        
        //observer relaoding the collection view when data came
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubCategoryViewContoller.updataSubCategoryViewController(_:)), name: "UpdateParentSubCategoryViewController", object: nil)
    }
    
    //when view will disappear
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UpdateParentSubCategoryViewController", object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    //number of cells in the collection view
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mParentSubcategoryViewModelObj.mParentSubcategoryList.count
    }

    //for each cell
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        //getting sub category
        let parentSubCategory : SubCategorylist? = mParentSubcategoryViewModelObj.mGetParentSubCategory(indexPath.row)
        
        //binding sub category to cell
        Utility().mBindCollectionViewCell(cell, subCategory: parentSubCategory!)
        
        return cell
    }
    
    //setting the sub category view
    @objc override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ParentingSubCategoryFooter", forIndexPath: indexPath)
        return footerView
    }
    
    //method to update subcategory view controller
    func updataSubCategoryViewController(notification : NSNotification) {
        stopActivityIndicator()
        let recievedCategories = mParentSubcategoryViewModelObj.mParentSubcategoryList.count
        let totalCategories = mParentSubcategoryViewModelObj.mTotalParentSubCategoryCount
        
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
    
    //adding footer with Activity indicator
    func layOutWithFooter() {
        
        //creating layout for cell in collection view
        collectionView!.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(self.view.frame),view: "parentSubCategoryFooter")
    }
    
    //removing footer from the collection view
    func layOutWithOutFooter() {
        collectionView!.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(self.view.frame),view: "parentSubCategory")
    }
    
    // MARK: UICollectionViewDelegate
    
    //for selected video
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        //getting the selected video url
        let url = NSURL(string: mParentSubcategoryViewModelObj.mParentSubcategoryList[indexPath.row].downloadUrl.value)
        
        //creating a avplayer
        mAvPlayer = AVPlayer(URL: url!)
        mAvPlayerViewController.player = mAvPlayer
        
        //showing in the video in avplayerviewcontroller
        self.presentViewController(mAvPlayerViewController, animated: true){
            
            //starting the video
            self.mAvPlayerViewController.player?.play()
        }
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
