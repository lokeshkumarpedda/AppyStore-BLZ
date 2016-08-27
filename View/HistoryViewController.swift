//
//  HistoryViewController.swift
//  AppyStoreBLZ
//
//  Created by BridgeLabz on 10/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class HistoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mheaderView: UIView!
    @IBOutlet weak var mHeaderLabel: UILabel!
    //buttons
    @IBOutlet weak var mBackButton: UIButton!
    @IBOutlet weak var mVideoButton: UIButton!
    @IBOutlet weak var mHistoryButton: UIButton!
    @IBOutlet weak var mSearchButton: UIButton!
    @IBOutlet weak var mCartButton: UIButton!
    
    let label = UILabel()
    
    var avPlayer = AVPlayer()
    var avPlayerViewController = AVPlayerViewController()
    
    var mHistoryViewModelObj : HistoryViewModel! //object of history view model
    var collectionViewCell : CollectionViewCell! //object of collection view cell
    
    override func viewDidLoad() {
        
        //setting background for button
        mBackButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mVideoButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mHistoryButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mSearchButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mCartButton.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        
        //setting background for view
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        mheaderView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        mHeaderLabel.text = "History"
        
        //setting image for buttons
        mChangeButtonImage()
        mHistoryButton.setImage(UIImage(named: "historybackground"), forState: UIControlState.Normal)
        
        //creating layout for cell in collection view
        collectionView.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(self.view.frame))
        
        //CollectionViewCell class registeration
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        mHistoryViewModelObj = HistoryViewModel(historyVCObj: self)
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //method will return number of section in collectionview
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //method will return number of item in each section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mHistoryViewModelObj.mHistoryList.count
    }
    //method will return collection view cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let history : SubCategorylist? = mHistoryViewModelObj.mHistoryList[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
      
        Utility().mBindCollectionViewCell(cell, subCategory: history!)

        return cell
    }
    
    
    //For selected video
    @objc func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        //getting the selected video url
        let url = NSURL(string: mHistoryViewModelObj.mHistoryList[indexPath.row].downloadUrl.value)
        
        //creating a avplayer
        avPlayer = AVPlayer(URL: url!)
        avPlayerViewController.player = avPlayer
        
        //showing in the video in avplayerviewcontroller
        self.presentViewController(avPlayerViewController, animated: true){
            
            //starting the video
            self.avPlayerViewController.player?.play()
        }
    }
    
    //method to update history view controller
    func updateHistoryViewController() {
        collectionView.reloadData()
    }

    @IBAction func mBackButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("HistoryToCategory", sender: nil)
    }

    @IBAction func mVideoButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("HistoryToCategory", sender: nil)
    }
    
    @IBAction func mHistoryButtonPressed(sender: UIButton) {
    }
    
    @IBAction func mSearchButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("HistoryToSearch", sender: nil)
    }
    
    @IBAction func mCartButtonPressed(sender: UIButton) {
        mChangeButtonImage()
        mCartButton.setImage(UIImage(named: "cartbackground.png"), forState: UIControlState.Normal)
        
        let alertController = UIAlertController(title: "Sorry !!", message: "Cart is not available at this time", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            self.mChangeButtonImage()
            self.mHistoryButton.setImage(UIImage(named: "historybackground"), forState: UIControlState.Normal)
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    //button to cleat history
    @IBAction func mClearHistory(sender: UIButton) {
        
        let alertController = UIAlertController(title: "CLEAR", message: "It will Clear you whole History", preferredStyle: UIAlertControllerStyle.Alert)
            
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            if self.mHistoryViewModelObj.deleteHistory(){
                self.mHistoryViewModelObj.mGetHistoryDetails()
            }
            else{
                print("-- Failed to Clear data --")
            }
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    //method to change background image of buttons
    func mChangeButtonImage () {
        mBackButton.setImage(UIImage(named: "backarrow.png"), forState: UIControlState.Normal)
        mVideoButton.setImage(UIImage(named: "videoimage.png"), forState: UIControlState.Normal)
        mHistoryButton.setImage(UIImage(named: "historyimage.png"), forState: UIControlState.Normal)
        mSearchButton.setImage(UIImage(named: "searchimage.png"), forState: UIControlState.Normal)
        mCartButton.setImage(UIImage(named: "carimage.png"), forState: UIControlState.Normal)
    }
}
