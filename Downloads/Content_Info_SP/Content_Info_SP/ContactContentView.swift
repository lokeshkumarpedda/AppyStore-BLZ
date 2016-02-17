//
//  ContactContentView.swift
//  Content_Info_SP
//
//  Created by Vidya Ramamurthy on 28/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class ContactContentView: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var profilePicImageView: UIImageView!
    var proImg : UIImage!
    var proImgName : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePicImageView.layer.borderWidth = 1.0
        profilePicImageView.layer.masksToBounds = false
        profilePicImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width/2
        profilePicImageView.clipsToBounds = true
        profilePicImageView.image = proImg
        //profilePicImageView.image = UIImage(named: proImgName)

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 // changed to CustomeCell when used CustomeCell
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
//        cell.textLabel?.text = "Opened ___ At ____ for "
//        cell.textLabel?.font = UIFont(name: "Futura", size: 8)!
//        cell.textLabel?.textColor = UIColor.lightGrayColor()
       
        return cell
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showContactConentAction")
        {
            let destinationVC = segue.destinationViewController as! ContactContentAction
            destinationVC.profPic = profilePicImageView.image
            //destinationVC.img = "1.jpg"
            //destinationVC.mediaImage = medianImageView1.image
            
        }
        
       
        
        

    
    
    }
    

}
