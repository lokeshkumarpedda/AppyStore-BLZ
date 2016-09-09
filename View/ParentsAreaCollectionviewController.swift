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
            return "Child Progress"
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
        if indexPath.row == 2{
            
            //For moving to parent categories
            performSegueWithIdentifier("ParentAreaToCategories", sender: nil)
            
        }
        else if indexPath.row == 4{
            
            //for rating the app
            appRating()
        }
        else if indexPath.row == 5{
            
            //sharing the app
            let shareText = "AppYStore Address"
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
            presentViewController(vc, animated: true, completion: nil)
            
        }
        else{
            //cells are not functionable
            underContructionMessage()
        }
    }
    
    //for giving ratings to the app
    func appRating() {
        let menu = UIAlertController(title: nil, message: "", preferredStyle: .ActionSheet)
        let one = UIAlertAction(title: "ONE", style: .Default, handler: {
            (result : UIAlertAction) -> Void in
            self.underContructionMessage()
        })
        let two = UIAlertAction(title: "TWO", style: .Default, handler: {
            (result : UIAlertAction) -> Void in
            self.underContructionMessage()
        })
        let three = UIAlertAction(title: "THREE", style: .Default, handler: {
            (result : UIAlertAction) -> Void in
            self.underContructionMessage()
        })
        let four = UIAlertAction(title: "FOUR", style: .Default, handler: {
            (result : UIAlertAction) -> Void in
            self.underContructionMessage()
        })
        let five = UIAlertAction(title: "FIVE", style: .Default, handler: {
            (result : UIAlertAction) -> Void in
            self.underContructionMessage()
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: {
            (result : UIAlertAction) -> Void in
            self.underContructionMessage()
        })
        menu.addAction(one)
        menu.addAction(two)
        menu.addAction(three)
        menu.addAction(four)
        menu.addAction(five)
        menu.addAction(cancelAction)
        self.presentViewController(menu, animated: true, completion: nil)
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