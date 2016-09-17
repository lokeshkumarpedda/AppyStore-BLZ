//
//  VideoPlayerViewController.swift
//  AppyStoreBLZ
//
//
//  purpose : 
//  Video player for playing video and playlist to select the video from.
//
//  Created by Lokesh Kumar on 18/08/16.
//
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
    @IBOutlet weak var mHeaderView: UIView!               //For time and slider display
    @IBOutlet weak var mVideoView: UIView!                //For video playing
    @IBOutlet weak var mPlayListView: UIView!             //For collection view display
    @IBOutlet weak var mButtonsView: UIView!              //For play controllers
    @IBOutlet weak var mDoneButton: UIButton!             //Going back to previous view
    @IBOutlet weak var mCurrentTimeLabel: UILabel!        //Current time of the video
    @IBOutlet weak var mTimeSlider: UISlider!             //Slider for moving the video
    @IBOutlet weak var mTotalTimeLabel: UILabel!          //Total video time label
    @IBOutlet weak var mPlayAndPauseButton: UIButton!     //Playing and pausing
    @IBOutlet weak var mPreviousVideoButton: UIButton!    //Previous video button
    @IBOutlet weak var mNextVideoButton: UIButton!        //Next video button
    @IBOutlet weak var mCollectionView: UICollectionView!  //For playlist collection view
    
    //MARK: - Class Variables
    var mUrl : NSURL?                                   //For current video url
    var mVideoPlayer = AVPlayer()                       //For AVPlayer
    var mVideoPlayerLayer : AVPlayerLayer?              //Layer for AVPlayer
    var mVideoPlayerItem : AVPlayerItem?                //Player Item for AVPlayer
    
    var mActivityIndicator = UIActivityIndicatorView()  //For loading
    let mActivityIndicatorContainer = UIView()          //For activity indicator display
    
    var mPlaying = true                                 //video is paused or playing
    var mCurrentVideoIndexPath = NSIndexPath()          //video indexpath for propagating
    var mCurrentVideoIndex = 0                          //video index for propagating
    let mFullScreenView = UIView()                      //for video fullscreen
    
    // Objects
    var mSubcategoryViewModelObj : SubCategoryViewModel!
    var mCategory : Categorylist!       //to store selected category from category view
    
    //MARK: - View methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Customizing all the views backgrounds
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        self.mHeaderView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.2)
        self.mPlayListView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        self.mVideoView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0)
        self.mButtonsView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0)
        mCollectionView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        
        //CollectionViewCell class registration
        mCollectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        layOutWithOutFooter()
        
        //adding observers for loading the collection view
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updataPlayList(_:)), name: "updatePlayList", object: nil)
    }
    
    //After appearing the view
    override func viewDidAppear(animated: Bool){
        
        super.viewDidAppear(true)

        BackGroundMusic.sharedPlayer.pauseMusic()
        //Timer to update slider for each second
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:#selector(updateSlider) , userInfo: nil, repeats: true)
        
        //adding taget to the slider
        mTimeSlider.addTarget(self, action: #selector(changeInSlider),
                             forControlEvents: .ValueChanged)
        
        //playing the video with url
        playerValues(mUrl!)
        
    }
    
    //After disappearing
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
            
        BackGroundMusic.sharedPlayer.playMusic()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Going back to subcategory with the current category details
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //stoping the video player
        mVideoPlayer.replaceCurrentItemWithPlayerItem(nil)
        
        //checking the identifier
        if segue.identifier == "VideoPlayerToSubCategory"{
            let subCategoryViewControllerObj = segue.destinationViewController as! SubCategoryViewContoller
            
            //sending subcategory to video player controller
            subCategoryViewControllerObj.mCategory = mCategory
        }
    }
    
    
    //MARK: - Video player methods
    
    //Setting video player
    func playerValues(url: NSURL) {
        
        //for sending the collection view to the particular indexpath
        goToIndex(mCurrentVideoIndexPath)
        
        //Pausing the previous video before loading the new video
        if mVideoPlayerItem != nil{
            mVideoPlayer.pause()
        }
        mVideoPlayerItem = nil
        mVideoPlayerLayer = nil
        
        //displaying the activity indicator
        showActivityIndicator()
        
        //loading the video player
        mVideoPlayerItem = AVPlayerItem(URL: url)
        mVideoPlayer = AVPlayer(playerItem: mVideoPlayerItem!)
        
            
        mVideoPlayerLayer = AVPlayerLayer(player: mVideoPlayer)
        mVideoView.layer.addSublayer(mVideoPlayerLayer!)
        
        mVideoPlayerLayer?.frame = mVideoView.bounds
        
        //video player will play
        mVideoPlayer.play()

        
        //Observer for starting the video
        mVideoPlayerItem!.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.New, context: nil)
        
        //Observer for checking if the buffer is empty
        mVideoPlayerItem!.addObserver(self, forKeyPath: "playbackBufferEmpty", options: NSKeyValueObservingOptions.New, context: nil)
        
        //Observer for when video is ready to play
        mVideoPlayerItem!.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: NSKeyValueObservingOptions.New, context: nil)
        
    }
    
    //For video loading and Buffering
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>){
        
        if keyPath == "status"{
            
            //checking the video is in playable status or not
            if mVideoPlayer.status == .ReadyToPlay && mVideoPlayerItem!.status == .ReadyToPlay{
                
                //stoping the activity indicator and removing it from the screen
                stopActivityIndicator()
                
                //adding gesture recognizer
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.tapToFullscreen(_:)))
                mVideoView.addGestureRecognizer(gestureRecognizer)
                
                //setting total time of the video to slider maximum value
                mTimeSlider.maximumValue = Float(Int(mVideoPlayerItem!.duration.value) / Int(mVideoPlayerItem!.duration.timescale))
                
                //setting total time label to maximum video length
                mTotalTimeLabel.text = convertingSeconds(Int(mTimeSlider.maximumValue))
                
                mVideoPlayer.play()
                mPlaying = true
            }
        }
        
        if keyPath == "playbackBufferEmpty"{
            
            //checking for the buffer is empty or not
            if ((mVideoPlayerItem?.playbackBufferEmpty) != nil){
                
                //stoping the video and loading
                showActivityIndicator()
                
                //video will be paused
                mVideoPlayer.pause()
            }
        }
            
        else if keyPath == "playbackLikelyToKeepUp"{
            
             //checking video is playable or not
            if ((mVideoPlayerItem?.playbackLikelyToKeepUp) != nil){
                
                //stoping the activity Indicator
                stopActivityIndicator()
                if mPlaying == true{
                    mVideoPlayer.play()
                }
                
            }
        }
    }
    
    //Video change with respective to the slider value change
    func changeInSlider(sender:UISlider!){
        
        //stoping the activity indicator
        stopActivityIndicator()
        
        //converting timeslider value to CMTIME
        let t = CMTimeMake(Int64( mTimeSlider.value), 1)
        
        //getting the video to slider value
        mVideoPlayer.seekToTime(t)
        
        //playing the video player
        if mPlaying == true{
            mVideoPlayer.play()
        }
        
    }
    
    //Slider change with respective to video
    func updateSlider(){
        
        //adding player time to the slider
        mTimeSlider.value = Float(Int( mVideoPlayerItem!.currentTime().value) / Int(mVideoPlayerItem!.currentTime().timescale))
        
        //adding time to the label
        mCurrentTimeLabel.text = convertingSeconds(Int(mTimeSlider.value))
        
    }
    
    //method for converting seconds to MM:SS times
    func convertingSeconds(sec : Int) -> String{
        
        let seconds = sec % 60
        let minutes = (sec / 60) % 60
        
        //For different cases of minutes and seconds
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
    
    //send the collection view for the particular position
    func goToIndex(indexpath : NSIndexPath) {
        
        //checking for is it the first two cells or not
        mCollectionView.scrollToItemAtIndexPath(indexpath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        
        //updating current index
        mCurrentVideoIndex = indexpath.row
    }
    //MARK: activity indicator methods
    
    //For activity indicator display and animation
    func showActivityIndicator(){
        
        //customizing container for activity indicator
        mActivityIndicatorContainer.frame = CGRectMake(0, 0, 40, 40)
        mActivityIndicatorContainer.center = mVideoView.center
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

    
    //MARK: gesture recognition methods
    
    //Playing video in fullscreen
    func tapToFullscreen(sender: UITapGestureRecognizer){
        //removing gesture recognizer from the fullscreen view
        for recognizer in mVideoView.gestureRecognizers!{
            mVideoView.removeGestureRecognizer(recognizer)
        }
        // setting screen to fullscreen
        mFullScreenView.frame = self.view.bounds
        mFullScreenView.backgroundColor = UIColor.blackColor()
        mFullScreenView.layer.addSublayer(mVideoPlayerLayer!)
        mVideoPlayerLayer?.frame = mFullScreenView.bounds
        self.view.addSubview(mFullScreenView)
        
        //Adding gesture recognition to the fullscreen
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.cancelingFullScreen(_:)))
        mFullScreenView.addGestureRecognizer(gestureRecognizer)
    }
    
    //cancelling the fullscreeen
    func cancelingFullScreen(sender: UITapGestureRecognizer){
        
        //removing gesture recognizer from the fullscreen view
        for recognizer in mFullScreenView.gestureRecognizers!{
            mFullScreenView.removeGestureRecognizer(recognizer)
        }
        //removing the fullscreen
        mFullScreenView.removeFromSuperview()
        mVideoView.layer.addSublayer(mVideoPlayerLayer!)
        mVideoPlayerLayer?.frame = mVideoView.bounds
  
        //adding gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPlayerViewController.tapToFullscreen(_:)))
        mVideoView.addGestureRecognizer(gestureRecognizer)
    }
    

    //MARK: - IBActions
    
    //Play and Pausing the video
    @IBAction func playAndPauseAction(sender: AnyObject) {
        
        //checking for it paused or running and doing the opposite
        if mPlaying == true{
            
            mVideoPlayer.pause()
            mPlaying = false
            
        }
        else{
            
            mVideoPlayer.play()
            mPlaying = true
            
        }
    }
    
    //For playing previous video
    @IBAction func previousVideoAction(sender: AnyObject) {
        
        //checking the video exists in subCategoryList
        if mCurrentVideoIndex > 0 && mCurrentVideoIndex < mSubcategoryViewModelObj.mSubcategoryList.count{
            
            //playing the video
            playerValues(NSURL(string: mSubcategoryViewModelObj.mSubcategoryList[mCurrentVideoIndex - 1].downloadUrl.value)!)
            mCurrentVideoIndex -= 1
        }
    }
    
    //For playing next video
    @IBAction func nextVideoAction(sender: AnyObject) {
        
        //checking the video exists in the subCategoryList
        if mCurrentVideoIndex+1 < mSubcategoryViewModelObj.mSubcategoryList.count {
            
            //playing video
            playerValues(NSURL(string: mSubcategoryViewModelObj.mSubcategoryList[mCurrentVideoIndex + 1].downloadUrl.value)!)
            
            //incrementing current video index
            mCurrentVideoIndex += 1
        }
    }

    //For updating the playlist
    func updataPlayList(notification : NSNotification){
        let recievedCategories = mSubcategoryViewModelObj.mSubcategoryList.count
        let totalCategories = mSubcategoryViewModelObj.mTotalSubCategoryCount
        
        //for first cells in the collection view
        if recievedCategories < 21{
            mCollectionView.reloadData()
        }
        //adding footer with activity indicator
        if recievedCategories < totalCategories{
            layOutWithFooter()
        }
        else{
            layOutWithOutFooter()
        }
        
    }
    
    func layOutWithFooter(){
    
        mCollectionView.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(mPlayListView.frame), view: "videoPlayerWithFooter")
    }
    func layOutWithOutFooter(){
        
        mCollectionView.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(mPlayListView.frame), view: "videoPlayer")
    }
}

//MARK: - CollectionView Datasource
extension VideoPlayerViewController: UICollectionViewDataSource{
    
    //method to return number of item in each section of collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return mSubcategoryViewModelObj.mSubcategoryList.count
        
    }
    
    //method to create collection view cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        //getting sub category for the index
        let subCategory : SubCategorylist? = mSubcategoryViewModelObj.mGetSubCategory(indexPath.row)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        //binding the sub category to cell
        Utility().mBindCollectionViewCell(cell, subCategory: subCategory!)
        
        return cell
    }
}

//MARK:- CollectionView Delegates
extension VideoPlayerViewController : UICollectionViewDelegate{
    //Selected video
    @objc func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        //getting the url for the selected sub category
        mUrl = NSURL(string: mSubcategoryViewModelObj.mSubcategoryList[indexPath.row].downloadUrl.value)
        
        //storing the selected indexpath and index value
        mCurrentVideoIndexPath = indexPath
        mCurrentVideoIndex = indexPath.row
        
        //playing the video with the url
        playerValues(mUrl!)
        
        //Adding to the history
        let LocalDB = LocalDataBase()
        LocalDB.mInsertInToHistoryTabel(mSubcategoryViewModelObj.mSubcategoryList[indexPath.row])
    }
    
    @objc func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "playlistFooter", forIndexPath: indexPath)
        return footerView
    }
    
}