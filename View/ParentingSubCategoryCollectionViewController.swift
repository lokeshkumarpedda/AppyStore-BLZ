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

class ParentingSubCategoryCollectionViewController: UICollectionViewController,
                                                PSubCategoryViewController {

    var mParentSubcategoryViewModelObj : ParentingSubcategoryViewModel!//viewmodel object
    var mParentCategory : Categorylist!   //to store selected category from category view
    
    var mAvPlayer = AVPlayer()              //For playing the video
    var mAvPlayerViewController = AVPlayerViewController()
    
    var mActivityIndicator = UIActivityIndicatorView()  //For loading
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for displaying the activity indicator
        mActivityIndicator =
            Utility().showActivityIndicator(mActivityIndicator,view : self.view)
        mActivityIndicator.startAnimating()
        self.navigationItem.title = mParentCategory.name.value
        
        mParentSubcategoryViewModelObj = ParentingSubcategoryViewModel(
            parentingSubCategory: mParentCategory!,
            obj :self)
        
        //setting the background
        collectionView?.backgroundColor =
            UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //CollectionViewCell class registration
        collectionView!.registerNib(UINib(nibName: reuseIdentifier, bundle: nil),
                                    forCellWithReuseIdentifier: reuseIdentifier)
        
        //creating layout for cell in collection view
        layOutWithOutFooter()
    }
    
    //when view appears playing the music
    override func viewWillAppear(animated: Bool) {
        
        BackGroundMusic.sharedPlayer.playMusic()
        
    }

    // MARK: UICollectionViewDataSource
    
    //number of cells in the collection view
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int)
                                 -> Int {
        return mParentSubcategoryViewModelObj.mParentSubcategoryList.count
    }

    //for each cell
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath)
                                 -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
                                        forIndexPath: indexPath) as! CollectionViewCell
        
        //getting sub category
        let parentSubCategory : SubCategorylist? =
            mParentSubcategoryViewModelObj.mGetParentSubCategory(indexPath.row)
        
        //binding sub category to cell
        Utility().mBindCollectionViewCell(cell, subCategory: parentSubCategory!)
        
        return cell
    }
    
    //setting the sub category view
    @objc override func collectionView(
        collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath)
        -> UICollectionReusableView{
            
        let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(
            kind,
            withReuseIdentifier: "ParentingSubCategoryFooter",
            forIndexPath: indexPath)
            
        return footerView
    }
    
    //method to update subcategory view controller
    func updataSubCategoryViewController() {
        mActivityIndicator.stopAnimating()
        let recievedCategories =
            mParentSubcategoryViewModelObj.mParentSubcategoryList.count
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
        collectionView!.collectionViewLayout = CustomViewFlowLayout(
            width : CGRectGetWidth(self.view.frame),
            height : CGRectGetHeight(self.view.frame),view: "parentSubCategory")
    }
    
    //removing footer from the collection view
    func layOutWithOutFooter() {
        
        //creating layout for cell in collection view
        collectionView!.collectionViewLayout = CustomViewFlowLayout(
            width : CGRectGetWidth(self.view.frame),
            height : CGRectGetHeight(self.view.frame),
            view: "parentSubCategorywithoutFooter")
    }
    
    // MARK: UICollectionViewDelegate
    
    //for selected video
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        BackGroundMusic.sharedPlayer.pauseMusic()
        
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

    //For going back to previous view
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: Activity indicator methods
}
