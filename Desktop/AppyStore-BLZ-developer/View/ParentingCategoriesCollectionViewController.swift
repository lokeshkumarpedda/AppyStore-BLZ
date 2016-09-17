//
//  ParentingCategoriesCollectionViewController.swift
//  AppyStoreBLZ
//
//  purpose :
//  For displaying parent categories
//
//  Created by Lokesh Kumar on 08/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
//reusing the identifier in this particular class
private let reuseIdentifier = "CollectionViewCell"

class ParentingCategoriesCollectionViewController: UICollectionViewController {

    var mParentCategoryVMobj : ParentingCategoriesViewModel! //model object reference
    var cache = NSCache()                                    //cache for storing images
    var mSelectedCategory : Categorylist!
    
    var mActivityIndicator = UIActivityIndicatorView()  //For loading
    let mActivityIndicatorContainer = UIView()          //For activity indicator display
    
    //When the view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        //creating model object
        mParentCategoryVMobj = ParentingCategoriesViewModel(parentCategoryVCobj: self)

        //setting the background
        collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        // Register cell classes
        collectionView!.registerNib(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        //setting the layout for cells
        collectionView!.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame) , height : CGRectGetHeight(self.view.frame))
    }

    //when memory exceeded
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //reload the collection view
    func updateVC() {
        
        collectionView?.reloadData()
        
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ParentCategoryToSubCategory" {
            let parentSubCategoryViewControllerObj = segue.destinationViewController as! ParentingSubCategoryCollectionViewController
            parentSubCategoryViewControllerObj.mParentCategory = mSelectedCategory
        }
        
    }

    // MARK: UICollectionViewDataSource

    //for number of sections
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    //for number of cells
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mParentCategoryVMobj.getCellsCount()
        
    }

    //for each cell
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let parentCategory: Categorylist? = mParentCategoryVMobj.getCellValues(indexPath.row)
        stopActivityIndicator()
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        let image = parentCategory?.image
        
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
        
        cell.VideoLabel.text = parentCategory?.name.value
        cell.imgUrl = image
        
        //checking image is in cache or not
        if let cachedImage = cache.objectForKey(image!) as? UIImage {
            cell.VideoImageView.image = cachedImage
        }
        else {
            let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: image!)!) {(data, response, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    if data != nil {
                        if let img = UIImage(data: data!) {
                            self.cache.setObject(img, forKey: image!)
                            if cell.imgUrl == image {
                                cell.VideoImageView.image = img
                                cell.activityIndicator.stopAnimating()
                                cell.activityIndicator.hidden = true
                            }
                        }
                    }
                })
            }
            task.resume()
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        mSelectedCategory = mParentCategoryVMobj.mParentCategoryList[indexPath.row]
        performSegueWithIdentifier("ParentCategoryToSubCategory", sender: mParentCategoryVMobj.getCellValues(indexPath.row))
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    //MARK: activity indicator methods
    
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
