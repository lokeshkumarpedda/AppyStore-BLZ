//
//  ContactContentAction.swift
//  Content_Info_SP
//
//  Created by Vidya Ramamurthy on 29/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class ContactContentAction: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profilePicIV: UIImageView!
    var profPic : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicIV.layer.borderWidth = 1.0
        profilePicIV.layer.masksToBounds = false
        profilePicIV.layer.borderColor = UIColor.whiteColor().CGColor
        profilePicIV.layer.cornerRadius = profilePicIV.frame.size.width/2
        profilePicIV.clipsToBounds = true
        // profilePicImageView.image = proImg
        profilePicIV.image = profPic      // Do any additional setup after loading the view.
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
        
        return cell
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
