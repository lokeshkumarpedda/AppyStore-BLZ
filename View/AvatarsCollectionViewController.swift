//
//  AvatarsCollectionViewController.swift
//  AppyStoreBLZ
//
//  Purpose : Displaying avatars to select from
//
//  Created by Lokesh kumar on 18/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class AvatarsCollectionViewController: UICollectionViewController,PAvatarViewController {

    var mAvatarVMobj : AvatarsViewModel!
    var cache = NSCache()
    var mActivityIndicator = UIActivityIndicatorView()
    
    var mSelectedAvatarId : Int?
    
    //When the view loaded
    override func viewDidLoad() {
        
        mActivityIndicator = Utility().showActivityIndicator(mActivityIndicator,
                                                             view : self.view)
        mActivityIndicator.startAnimating()
        
        //setting the background
        collectionView?.backgroundColor =
            UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        // Register cell classes
        collectionView!.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "CollectionViewCell")
        
        super.viewDidLoad()
        //setting the layout for cells
        collectionView!.collectionViewLayout = CustomViewFlowLayout(
            width : CGRectGetWidth(self.view.frame) ,
            height : CGRectGetHeight(self.view.frame))
        
        //creating view model object
        mAvatarVMobj = AvatarsViewModel(obj: self)
        
    }
    //when view will disappear
    override func viewWillDisappear(animated: Bool) {
        
        //removing the observer
        NSNotificationCenter.defaultCenter()
            .removeObserver(self, name: "UpdateAvatarsViewController", object: nil)
    }
    // MARK: UICollectionViewDataSource
    
    //number of cells in the collection view
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return mAvatarVMobj!.getCellsCount()
    }
    
    //for each cell
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath)
                                 -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell",
                                        forIndexPath: indexPath) as! CollectionViewCell
        
        //getting sub category
        let avatar : Avatar = mAvatarVMobj!.getAvatar(indexPath.row)
        let image = avatar.avatarUrl
        cell.VideoLabel.text = String(avatar.avatarId)
        cell.activityIndicator.hidden = true
        
        cell.VideoImageView.image =
            UIImage(named: "angry_birds_space_image_rectangular_box")
                                    
        cell.VideoImageView.layer.cornerRadius =
            (cell.VideoImageView.frame.size.height/2)
                                    
        cell.VideoImageView.clipsToBounds = true
        cell.VideoDurationLabel.hidden = true
        
        //activity indicator
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.color = UIColor.whiteColor()
        cell.imgUrl = image
        if let cachedImage = cache.objectForKey(image!) as? UIImage {
            cell.VideoImageView.image = cachedImage
            
        }
        else {
            let task = NSURLSession.sharedSession().dataTaskWithURL(
                                    NSURL(string: image!)!) {(data, response, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    if data != nil {
                        if let img = UIImage(data: data!) {
                            self.cache.setObject(img, forKey: image!)
                            cell.VideoImageView.layer.cornerRadius = 0
                            if cell.imgUrl == image {
                                cell.VideoImageView.image = img
                            }
                            cell.activityIndicator.stopAnimating()
                        }
                    }
                })
            }
            task.resume()
        }
        
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate
    
    //when collection view cell selected
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath){
        mSelectedAvatarId = mAvatarVMobj!.getAvatar(indexPath.row).avatarId
        performSegueWithIdentifier("AvatarToRegistration", sender: nil)
    }
    
    //updating view controller
    func updateAvatarVC(){
        mActivityIndicator.stopAnimating()
        collectionView?.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AvatarToRegistration" {
            let registrationChildVCObj =
                segue.destinationViewController as! RegisterChildViewController
            registrationChildVCObj.mSelectedAvatar = mSelectedAvatarId
        }
    }
    //Going to previous view controller
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}
