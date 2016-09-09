//
//  ParentsAreaCollectionviewController.swift
//  AppyStoreBLZ
//
//  Purpose :
//  Displaying parent area details
//
//  Created by Lokesh Kumar on 07/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class ParentsAreaCollectionviewController: UICollectionViewController {

    override func viewDidLoad() {
        collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        self.navigationController?.view.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.1)
        //Layouts for the cells
        collectionView!.collectionViewLayout = CustomViewFlowLayout(width : CGRectGetWidth(self.view.frame) , height : CGRectGetHeight(self.view.frame) , view: "parentArea")
    }
    
    //MARK: CollectionView DataSource
    //number of cells
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 6
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! parentsAreaCell
        //getting the text in to the cell
        cell.textLabel?.text = getCellName(indexPath.row)
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
    @objc override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        if indexPath.row == 2{
            
            performSegueWithIdentifier("ParentAreaToCategories", sender: nil)
            
        }
        else{
            //creating alert view
            let alertController = UIAlertController(title: "Sorry !!", message: "Not available at this time", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

//class for each reusable custom cell
class parentsAreaCell: UICollectionViewCell{
    
    @IBOutlet weak var textLabel: UILabel?
    
}