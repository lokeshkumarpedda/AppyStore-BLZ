//
//  VideoPlayerViewController.swift
//  AppyStoreBLZ
//

//purpose : Video player for playing video and playlist to select the video from.


//  Created by BridgeLabz on 18/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ReactiveKit
import ReactiveUIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{

    //MARK: OUTLETS
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playListView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var playAndPauseButton: UIButton!
    @IBOutlet weak var previousVideoButton: UIButton!
    @IBOutlet weak var nextVideoButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    var url : NSURL?
    var videoPlayer = AVPlayer()
    var videoPlayerLayer : AVPlayerLayer?
    var videoPlayerItem : AVPlayerItem?
    
    var activityIndicator = UIActivityIndicatorView()
    
    // Objects
    var subcategoryViewModelObj : SubCategoryViewModel!
    var collectionViewCell : CollectionViewCell?
    var category : categorylist!   //to store selected category from category view
    //------------------------------
    
    //MARK: - View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        self.headerView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.2)
        self.playListView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        
        //CollectionViewCell class registeration
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        //creating layout for cell in collection view
        collectionView.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(playListView.frame),height : CGRectGetHeight(playListView.frame), view: "VideoPlayer")
        
        collectionView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        subcategoryViewModelObj = SubCategoryViewModel(category: category!)
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(true)

        //Timer to update slider for each second
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:#selector(self.updateSlider) , userInfo: nil, repeats: true)
        
        timeSlider.addTarget(self, action: #selector(changeInSlider),
                             forControlEvents: .ValueChanged)
        playerValues(url!, currentView: videoView)
        
    }
    
    //Setting video player
    func playerValues(url: NSURL , currentView : UIView) {
        
        videoPlayerItem = AVPlayerItem(URL: url)
        videoPlayer = AVPlayer(playerItem: videoPlayerItem!)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
        currentView.layer.addSublayer(videoPlayerLayer!)
        videoPlayerLayer?.frame = currentView.bounds
        videoPlayerLayer!.videoGravity = AVLayerVideoGravityResizeAspect
        videoPlayer.play()
        videoPlayerItem!.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.New, context: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VideoPlayerToSubCategory" {
            let subCategoryViewControllerObj = segue.destinationViewController as! SubCategoryViewContoller
            subCategoryViewControllerObj.mCategory = category
        }
    }
    
    //For video loading
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>)
    {
        
        if keyPath == "status"
        {
            if videoPlayer.status == .ReadyToPlay && videoPlayerItem!.status == .ReadyToPlay
            {
                
                activityIndicator.stopAnimating()
                timeSlider.maximumValue = Float(Int(videoPlayerItem!.duration.value) / Int(videoPlayerItem!.duration.timescale))
                totalTimeLabel.text = convertingSeconds(Int(timeSlider.maximumValue))
                
            }
            else {
                
                //Showing network error message
                let alertController = UIAlertController(title: "Network Error", message: "Please check your Internet connnection", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: {(result : UIAlertAction) -> Void in
                    self.performSegueWithIdentifier("VideoPlayertoSubcategory", sender: nil)
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    //Video change with respective to the slider value change
    func changeInSlider(sender:UISlider!)
    {
        let t = CMTimeMake(Int64( timeSlider.value), 1)
        videoPlayer.seekToTime(t)
        
        videoPlayer.play()
    }
    
    //Slider change with respective to video
    func updateSlider(){
        timeSlider.value = Float(Int( videoPlayerItem!.currentTime().value) / Int(videoPlayerItem!.currentTime().timescale))
        currentTimeLabel.text = convertingSeconds(Int(timeSlider.value))
        
    }
    
    func showActivityIndicator(view: UIView)
    {
        
        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        //Adding activity indicator to particular view
        view.addSubview(activityIndicator)
        
        //Staring the the animation
        activityIndicator.startAnimating()
        
    }
    
    //method for converting seconds to HH:MM:SS times
    func convertingSeconds(sec : Int) -> String
    {
        
        let seconds = sec % 60
        let minutes = (sec / 60) % 60
        if seconds < 10 && minutes < 10
        {
            return "0" + String(minutes) + ":" + "0" + String(seconds)
            
        }else if seconds < 10 {
            
            return String(minutes) + ":" + "0" + String(seconds)
            
        }else if minutes < 10{
            
            return "0" + String(minutes) + ":" + String(seconds)
            
        }else {
            
            return String(minutes) + ":" + String(seconds)
            
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func doneButtonAction(sender: AnyObject) {
    }
    
    @IBAction func playAndPauseAction(sender: AnyObject) {
    }
    
    @IBAction func previousVideoAction(sender: AnyObject) {
    }
    @IBAction func nextVideoAction(sender: AnyObject) {
    }

    //MARK: - PlayList methods
    
    
    //method to return number of item in each section of collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return subcategoryViewModelObj.mTotalSubCategoryCount
        
    }
    
    //method to create collection view cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let subCategory : SubCategorylist? = subcategoryViewModelObj.mGetSubCategory(indexPath.row)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        Utility().mBindCollectionViewCell(cell, subCategory: subCategory!)
        
        return cell
    }
    
    //Selected video
    @objc func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        url = NSURL(string: subcategoryViewModelObj.mSubcategoryList[indexPath.row].downloadUrl.value)
        
        //playing the video with the url
        self.showActivityIndicator(videoView)
        self.playerValues(url!, currentView: videoView)
        
        //Adding to the history
        let LocalDB = LocalDataBase()
        LocalDB.mInsertInToHistoryTabel(subcategoryViewModelObj.mSubcategoryList[indexPath.row])
        
    }

    
    //For updating the playlist
    func updataSubCategoryViewController(notification : NSNotification)
    {
        
        collectionView.reloadData()
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
        
    }
}
