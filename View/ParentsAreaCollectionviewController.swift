//
//  ParentsAreaCollectionviewController.swift
//  AppyStoreBLZ
//
//  Purpose :
//  Displaying parent area details
//
//  Created by Lokesh Kumar on 07/09/16.
//
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
//Using the collection view controller
class ParentsAreaCollectionviewController: UICollectionViewController {

    //when view is loaded
    override func viewDidLoad() {
        //setting the collection view back ground
        collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //Layouts for the cells
        collectionView!.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame) , height : CGRectGetHeight(self.view.frame) , view: "parentArea")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        BackGroundMusic.sharedPlayer.playMusic()
        
    }
    //MARK: CollectionView DataSource
    
    //number of cells
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        //it is static because the view is statically created
        return 6
    }
    
    //For each cell
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        //using reusable cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! parentsAreaCell
        
        //getting the text in to the cell
        cell.textLabel?.text = getCellName(indexPath.row)
        
        //cell design
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.blueColor().colorWithAlphaComponent(0.2).CGColor
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        return cell
    }
    
    //For getting the names of the particular cell
    func getCellName(index : Int) -> String {
        switch(index) {
        case 0 :
            return "Child Details"
        case 1 :
            return "Register Child"
        case 2 :
            return "Parenting Videos"
        case 3 :
            return "View Plans"
        case 4 :
            return "Rate the App"
        case 5 :
            return "Share the App"
        default : break
        }
        return "not found"
    }
    
    //MARK: CollectionView Delegate
    
    //For selected cell
    @objc override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        //each functionaly for each cell
        if indexPath.row == 0{
            
            underContructionMessage()
            
        }
        else if indexPath.row == 1{
            
            //Going into the registration
            performSegueWithIdentifier("ParentAreaToAvatars", sender: nil)
            
        }
        else if indexPath.row == 2{
            
            //For moving to parent categories
            performSegueWithIdentifier("ParentAreaToCategories", sender: nil)
            
        }
        else if indexPath.row == 3 || indexPath.row == 4{
            //stoping the music
            BackGroundMusic.sharedPlayer.pauseMusic()
            
            //for going to appy store
            performSegueWithIdentifier("ParentAreaToRating", sender: nil)
        }
        else if indexPath.row == 5{
            //sharing the app
            let shareText = "Give the right start to your child's learning, check out Appystore's latest app at https://play.google.com/store/apps/details?id=com.appy.store.lite"
            let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
            presentViewController(activityViewController, animated: true, completion: nil)
            
        }
    }
    
    //Telling about non functionable cells
    func underContructionMessage()  {
        //creating alert view
        let alertController = UIAlertController(title: "Sorry !!", message: "Not available at this time", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}


//class for customizing the cells
class parentsAreaCell: UICollectionViewCell{
    
    @IBOutlet weak var textLabel: UILabel?
    
}