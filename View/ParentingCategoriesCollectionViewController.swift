//
//  ParentingCategoriesCollectionViewController.swift
//  AppyStoreBLZ
//
//  Created by BridgeLabz on 08/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class ParentingCategoriesCollectionViewController: UICollectionViewController {

    var mParentCategoryVMobj : ParentingCategoriesViewModel!
    var cache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mParentCategoryVMobj = ParentingCategoriesViewModel(parentCategoryVCobj: self)
        self.clearsSelectionOnViewWillAppear = false

        collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView!.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        collectionView!.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame) , height : CGRectGetHeight(self.view.frame))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateVC() {
        collectionView?.reloadData()
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

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mParentCategoryVMobj.getCellsCount()
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let parentCategory: Categorylist? = mParentCategoryVMobj.getCellValues(indexPath.row)
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

}
