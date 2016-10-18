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
import Alamofire
import AlamofireImage

//reusing the identifier in this particular class
private let reuseIdentifier = "CollectionViewCell"

class ParentingCategoriesCollectionViewController: UICollectionViewController ,PCategoryViewController{

    var mParentCategoryVMobj : ParentingCategoriesViewModel! //model object reference
    var cache = AutoPurgingImageCache()                                    //cache for storing images
    var mSelectedCategory : Categorylist!                    //selected category
    
    var mActivityIndicator = UIActivityIndicatorView()  //For loading
    
    //When the view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mActivityIndicator = Utility().showActivityIndicator(mActivityIndicator,view : self.view)
        mActivityIndicator.startAnimating()
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
    func updateCategoryViewController() {
        
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
        mActivityIndicator.stopAnimating()
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
        if let cachedImage = cache.imageWithIdentifier(image!){
            cell.VideoImageView.image = cachedImage
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

    // MARK: UICollectionViewDelegate
    
    //when collection view cell selected
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        //storing the selected category
        mSelectedCategory = mParentCategoryVMobj.mParentCategoryList[indexPath.row]
        
        performSegueWithIdentifier("ParentCategoryToSubCategory", sender: nil)
    }

    
    @IBAction func backButtonPressed(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }


}
