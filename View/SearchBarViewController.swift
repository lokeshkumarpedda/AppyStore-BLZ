//
//  SearchBarViewController.swift
//  AppyStoreApplication
//  Purpose
//  1. This class allow user to enter text for search video
//  2. It provide few buttons of easy search
//  3. This class will display all search result videos
//
//  Created by Shelly on 22/07/16.


//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import ReactiveKit
import Alamofire
import AVKit
import AVFoundation

class SearchBarViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,PSearchViewController,UITextFieldDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backButtonLabel: UIButton!
    @IBOutlet weak var searchButtonLabel: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    var collectionViewCell : CollectionViewCell?
    
    var mSearchViewModelObj : SearchViewMode!
    var mVideoPlayer : AVPlayer!
    var mPlayerViewController : AVPlayerViewController!
    let label = UILabel()
    var searchButtonShow : Bool = true
    var Sview = UIView(frame: CGRect(x: 0, y: 0, width: 540, height: 60))
    var sViewButton : UIButton!
    var headerViewChecker : Bool = true
    var ListCount = 0
    var searchKeyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mSearchViewModelObj = SearchViewMode(searchVCObj: self) //create object of serach view model
        //creating layout for cell in collection view
        collectionView.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame),height : CGRectGetHeight(self.view.frame))
        
        //CollectionViewCell class registeration
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        //setting background image
        backButtonLabel.setImage(UIImage(named: "backarrow.png"), forState: UIControlState.Normal)
        searchButtonLabel.setImage(UIImage(named: "searchimage.png"), forState: UIControlState.Normal)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage.jpg")!)
        //to dismiss keyboard
        inputTextField.delegate = self
    }

    //method to dismiss keyboard when return button pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        inputTextField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
    //method will return number of sections in colleciton view
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //method will return number of rows in each collection view section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mSearchViewModelObj.mTotalSearchCategory
    }
    //method will return collection view cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let searchCategory : SubCategorylist? = mSearchViewModelObj.mGetSearchCategory(indexPath.row)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        Utility().mBindCollectionViewCell(cell, subCategory: searchCategory!)

        return cell
    }
    //method get called any item in collection view is pressed
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let url = NSURL(string: mSearchViewModelObj.mSearchList[indexPath.row].downloadUrl.value)
        mVideoPlayer = AVPlayer(URL: url!)
        mPlayerViewController = AVPlayerViewController()
        
        mPlayerViewController.player = mVideoPlayer
        self.presentViewController(mPlayerViewController, animated: true ){
        self.mPlayerViewController.player?.play()
        }
        
        //adding to history
        let LocalDB = LocalDataBase()
        LocalDB.mInsertInToHistoryTabel(mSearchViewModelObj.mSearchList[indexPath.row])
    }
    //method to display header in collection view for easy search buttons
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {

        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView",forIndexPath: indexPath) as! CollectionReusableView
        cell.mSetBorder()
        return cell
    }
    //mehtod will return size of collection view header
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
            if (headerViewChecker != true ){
                return CGSizeZero
            }
            else {
                   return CGSize(width: (view.frame.size.width), height: 90)
            }
    }
    
    //method to update search view controller
    func updateSearchViewController() {
        if mSearchViewModelObj.mTotalSearchCategory > 0 {
            collectionView.reloadData()
        }
        else {
            label.hidden = false
            label.textAlignment = NSTextAlignment.Center
            label.text = "Records Not Found"
            label.textColor = UIColor.whiteColor()
            collectionView.backgroundView = label
        }
    }
    
    //method to create subview to display when search not found
    func mCreateSubVIew() {
        Sview.backgroundColor = UIColor.blackColor()
        collectionView.addSubview(Sview)
    }
    //button actions
    @IBAction func backButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("SearchToCategory", sender: nil)
    }
    
    @IBAction func searchButtonPressed(sender: UIButton) {
        searchKeyword = inputTextField.text!
        Sview.hidden = true
        headerViewChecker = false
        if searchButtonShow {
            if inputTextField.text == "" {
                
            }
            else {
                searchButtonShow = false
                collectionView.reloadData()
                label.hidden = true
                print(searchKeyword)
                mSearchViewModelObj.mFetchSearchCategoryDetailsFromController(searchKeyword)
                searchButtonLabel.setImage(UIImage(named: "close"), forState: UIControlState.Normal)
                searchButtonLabel.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
            }
        }
        else {
            searchButtonLabel.setImage(UIImage(named: "searchimage.png"), forState: UIControlState.Normal)
            searchButtonShow = true
            inputTextField.text = ""
        }
    }
    

    @IBAction func CollectionReusableViewButton(sender: UIButton) {
        
        switch(sender.tag) {
        case 1 :
            inputTextField.text = "Rhymes"
            break
        case 2 :
            inputTextField.text = "Letters"
            break
        case 3 :
            inputTextField.text = "Counting"
            break
        case 4 :
            inputTextField.text = "Drawing"
            break
        case 5 :
            inputTextField.text = "Science"
            break
        case 6 :
            inputTextField.text = "Numbers"
            break
        case 7 :
            inputTextField.text = "Puzzles"
            break
        case 8 :
            inputTextField.text = "ABC"
            break
        case 9 :
            inputTextField.text = "Reading"
            break
        case 10 :
            inputTextField.text = "Alphabet"
            break
        default : break
        }
        searchButtonPressed(sender)
    }
}
