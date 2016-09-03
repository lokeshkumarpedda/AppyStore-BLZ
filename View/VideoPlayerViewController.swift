//
//  VideoPlayerViewController.swift
//  AppyStoreBLZ
//

//purpose : Video player for playing video and playlist to select the video from.

//  Created by Lokesh Kumar on 18/08/16.

//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ReactiveKit
import ReactiveUIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController {

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
    
    //MARK: - Class Variables
    var murl : NSURL?
    var mvideoPlayer = AVPlayer()
    var mvideoPlayerLayer : AVPlayerLayer?
    var mvideoPlayerItem : AVPlayerItem?
    
    var activityIndicator = UIActivityIndicatorView()
    let activityIndicatorContainer = UIView()
    
    var mpause = true
    var mcurrentVideoIndex: Int = 0
    
    let mfullScreenView = UIView()
    
    // Objects
    var msubcategoryViewModelObj : SubCategoryViewModel!
    var collectionViewCell : CollectionViewCell?
    var mcategory : categorylist!   //to store selected category from category view
    //------------------------------
    
    
    
    //MARK: - View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customizing all the views backgrounds
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        self.headerView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.2)
        self.playListView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        self.videoView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0)
        self.buttonsView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0)
        collectionView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        
        //CollectionViewCell class registeration
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        //creating layout for cell in collection view
        collectionView.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(playListView.frame),height : CGRectGetHeight(playListView.frame), view: "VideoPlayer")
        
        msubcategoryViewModelObj = SubCategoryViewModel(category: mcategory!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updataPlayList(_:)), name: "updatePlayList", object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(true)

        //Timer to update slider for each second
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:#selector(updateSlider) , userInfo: nil, repeats: true)
        
        //adding taget to the slider
        timeSlider.addTarget(self, action: #selector(changeInSlider),
                             forControlEvents: .ValueChanged)
        
        playerValues(murl!)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Going back to subcategory with the current category details
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        mvideoPlayer.replaceCurrentItemWithPlayerItem(nil)
        if segue.identifier == "VideoPlayerToSubCategory"{
            let subCategoryViewControllerObj = segue.destinationViewController as! SubCategoryViewContoller
            subCategoryViewControllerObj.mCategory = mcategory
        }
    }
    
    
    //MARK: - Video player methods
    
    //Setting video player
    func playerValues(url: NSURL) {
        
        //Pausing the previous video before loading the new video
        if mvideoPlayerItem != nil{
            mvideoPlayer.pause()
        }
        mvideoPlayerItem = nil
        mvideoPlayerLayer = nil
        showActivityIndicator()
        
        mvideoPlayerItem = AVPlayerItem(URL: url)
        mvideoPlayer = AVPlayer(playerItem: mvideoPlayerItem!)
        mvideoPlayerLayer = AVPlayerLayer(player: mvideoPlayer)
        
        videoView.layer.addSublayer(mvideoPlayerLayer!)
        mvideoPlayerLayer?.frame = videoView.bounds
        mvideoPlayer.play()

        
        //Adding observer for buffering
        mvideoPlayerItem!.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.New, context: nil)
        mvideoPlayerItem!.addObserver(self, forKeyPath: "playbackBufferEmpty", options: NSKeyValueObservingOptions.New, context: nil)
        mvideoPlayerItem!.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: NSKeyValueObservingOptions.New, context: nil)
        
    }
    
    //For video loading and Buffering
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>){
        
        if keyPath == "status"{
            //checking the video is in playable status or not
            if mvideoPlayer.status == .ReadyToPlay && mvideoPlayerItem!.status == .ReadyToPlay{
                
                stopActivityIndicator()
                
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.tapToFullscreen(_:)))
                videoView.addGestureRecognizer(gestureRecognizer)
                
                timeSlider.maximumValue = Float(Int(mvideoPlayerItem!.duration.value) / Int(mvideoPlayerItem!.duration.timescale))
                totalTimeLabel.text = convertingSeconds(Int(timeSlider.maximumValue))
                
            }
        }
        
        if keyPath == "playbackBufferEmpty"{
            //checking for the buffer is empty or not
            if ((mvideoPlayerItem?.playbackBufferEmpty) != nil){
                
                showActivityIndicator()
                mvideoPlayer.pause()
                
            }
        }
        else if keyPath == "playbackLikelyToKeepUp"{
            
             //checking video is playable or not
            if ((mvideoPlayerItem?.playbackLikelyToKeepUp) != nil){
                
                stopActivityIndicator()
                mvideoPlayer.play()
                
            }
        }
    }
    
    //Video change with respective to the slider value change
    func changeInSlider(sender:UISlider!){
        
        stopActivityIndicator()
        let t = CMTimeMake(Int64( timeSlider.value), 1)
        mvideoPlayer.seekToTime(t)
        mvideoPlayer.play()
        
    }
    
    //Slider change with respective to video
    func updateSlider(){
        
        //adding player time to the slider
        timeSlider.value = Float(Int( mvideoPlayerItem!.currentTime().value) / Int(mvideoPlayerItem!.currentTime().timescale))
        //adding time to the label
        currentTimeLabel.text = convertingSeconds(Int(timeSlider.value))
        
    }
    
    //method for converting seconds to MM:SS times
    func convertingSeconds(sec : Int) -> String{
        
        let seconds = sec % 60
        let minutes = (sec / 60) % 60
        if seconds < 10 && minutes < 10{
            return "0" + String(minutes) + ":" + "0" + String(seconds)
            
        }else if seconds < 10{
            
            return String(minutes) + ":" + "0" + String(seconds)
            
        }else if minutes < 10{
            
            return "0" + String(minutes) + ":" + String(seconds)
            
        }else{
            
            return String(minutes) + ":" + String(seconds)
            
        }
    }
    
    //MARK: activity indicator methods
    
    //For activity indicator display and animation
    func showActivityIndicator(){
        
        activityIndicatorContainer.frame = CGRectMake(0, 0, 40, 40)
        activityIndicatorContainer.center = videoView.center
        activityIndicatorContainer.backgroundColor = UIColor.darkGrayColor()
        activityIndicatorContainer.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
        activityIndicator.activityIndicatorViewStyle = .White
        activityIndicator.clipsToBounds = true
        activityIndicator.hidesWhenStopped = true
        
        //Adding activity indicator to particular view
        activityIndicatorContainer.addSubview(activityIndicator)
        view.addSubview(activityIndicatorContainer)
        
        //Staring the the animation
        activityIndicator.startAnimating()
        
    }
    
    //For stop displaying the activity indicator
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicatorContainer.removeFromSuperview()
    }

    
    //MARK: gesture recognition methods
    
    //Playing video in fullscreen
    func tapToFullscreen(sender: UITapGestureRecognizer){
        //removing gesture recognizer from the fullscreen view
        for recognizer in videoView.gestureRecognizers!{
            videoView.removeGestureRecognizer(recognizer)
        }
        
        mfullScreenView.frame = self.view.bounds
        mfullScreenView.backgroundColor = UIColor.blackColor()
        mfullScreenView.layer.addSublayer(mvideoPlayerLayer!)
        mvideoPlayerLayer?.frame = mfullScreenView.bounds
        self.view.addSubview(mfullScreenView)
        
        //Adding gesture recognition to the fullscreen
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.cancelingFullScreen(_:)))
        mfullScreenView.addGestureRecognizer(gestureRecognizer)
    }
    

    
    //cancelling the fullscreeen
    func cancelingFullScreen(sender: UITapGestureRecognizer){
        
        //removing gesture recognizer from the fullscreen view
        for recognizer in mfullScreenView.gestureRecognizers!{
            mfullScreenView.removeGestureRecognizer(recognizer)
        }
        mfullScreenView.removeFromSuperview()
        videoView.layer.addSublayer(mvideoPlayerLayer!)
        mvideoPlayerLayer?.frame = videoView.bounds
  
        //adding gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.tapToFullscreen(_:)))
        videoView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    //MARK: - IBActions
    
    //Play and Pausing the video
    @IBAction func playAndPauseAction(sender: AnyObject) {
        
        //checking for it paused or running and doing the opposite
        if mpause == true{
            
            mvideoPlayer.pause()
            mpause = false
            
        }
        else{
            
            mvideoPlayer.play()
            mpause = true
            
        }
    }
    
    //For playing previous video
    @IBAction func previousVideoAction(sender: AnyObject) {
        
        //checking the video exists in subCategoryList
        if mcurrentVideoIndex > 0 && mcurrentVideoIndex < msubcategoryViewModelObj.mSubcategoryList.count{
            
            playerValues(NSURL(string: msubcategoryViewModelObj.mSubcategoryList[mcurrentVideoIndex - 1].downloadUrl.value)!)
            mcurrentVideoIndex -= 1
        }
    }
    
    //For playing next video
    @IBAction func nextVideoAction(sender: AnyObject) {
        
        //checking the video exists in the subCategoryList
        if mcurrentVideoIndex+1 < msubcategoryViewModelObj.mSubcategoryList.count {
            
            playerValues(NSURL(string: msubcategoryViewModelObj.mSubcategoryList[mcurrentVideoIndex + 1].downloadUrl.value)!)
            mcurrentVideoIndex += 1
        }
    }




    
    //For updating the playlist
    func updataPlayList(notification : NSNotification){
        
        collectionView.reloadData()
        
    }
}

//MARK: - CollectionView Datasource
extension VideoPlayerViewController: UICollectionViewDataSource{
    
    
    //method to return number of item in each section of collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return msubcategoryViewModelObj.mTotalSubCategoryCount
        
    }
    
    //method to create collection view cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let subCategory : SubCategorylist? = msubcategoryViewModelObj.mGetSubCategory(indexPath.row)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        Utility().mBindCollectionViewCell(cell, subCategory: subCategory!)
        
        return cell
    }
}

//MARK:- CollectionView Delegates
extension VideoPlayerViewController : UICollectionViewDelegate{
    //Selected video
    @objc func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        murl = NSURL(string: msubcategoryViewModelObj.mSubcategoryList[indexPath.row].downloadUrl.value)
        mcurrentVideoIndex = indexPath.row
        
        //playing the video with the url
        playerValues(murl!)
        
        //Adding to the history
        let LocalDB = LocalDataBase()
        LocalDB.mInsertInToHistoryTabel(msubcategoryViewModelObj.mSubcategoryList[indexPath.row])
        
    }
}
