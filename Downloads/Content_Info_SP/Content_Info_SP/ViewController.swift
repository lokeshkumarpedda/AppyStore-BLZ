//
//  ViewController.swift
//  Content_Info_SP
//
//  Created by Vidya Ramamurthy on 25/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import MessageUI
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UIGestureRecognizerDelegate, UISearchResultsUpdating, MFMessageComposeViewControllerDelegate{
    
    @IBAction func sendMessage(sender: AnyObject) {
    }
    @IBOutlet weak var myTableVIew: UITableView!
    var peopleName=["Meena","Heena","Seema","Vijay","Rajiv","Akshay","Kareena"]
    var profilepic = ["hd_nature_wallpaper.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg"]
    
    var totalViews = ["20","30","12","2","9","28","4"]
    var filteredPeople = [String]()
    var contentTitle : String!
    var contentFlag = false
    
    
    var segue: UIStoryboardSegue!
    
    
    @IBOutlet weak var contentTitleLable: UILabel!
    @IBOutlet weak var groupPhotoImageView: UIImageView!
    
    @IBOutlet weak var medianImageView1: UIImageView!
    
    @IBOutlet weak var medianImageView2: UIImageView!
    
    @IBOutlet weak var medianImageView3: UIImageView!
    
    @IBOutlet weak var medianImageView4: UIImageView!
    
    @IBOutlet weak var medianImageView5: UIImageView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    var resultSearchController = UISearchController()
    
    let phoneNumber : String = "9878978"
    
    var imagess : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        groupPhotoImageView.image = UIImage(named: "hd_nature_wallpaper.jpg")
        
        // Setting Media Image
        medianImageView1.layer.borderColor = UIColor.redColor().CGColor
        medianImageView1.layer.borderWidth = 1.0
        medianImageView1.layer.masksToBounds = false
        medianImageView1.clipsToBounds = true
        medianImageView1.contentMode = .ScaleAspectFill
        medianImageView1.image = UIImage(named: "im1.jpg")
        
        // tap Geasture Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        medianImageView1.userInteractionEnabled = true
        medianImageView1.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        medianImageView2.layer.borderColor = UIColor.redColor().CGColor
        medianImageView2.layer.borderWidth = 1.0
        medianImageView2.layer.masksToBounds = false
        medianImageView2.clipsToBounds = true
        medianImageView2.contentMode = .ScaleAspectFill
        medianImageView2.image = UIImage(named: "im2.jpg")
        
        medianImageView3.layer.borderColor = UIColor.redColor().CGColor
        medianImageView3.layer.borderWidth = 1.0
        medianImageView3.layer.masksToBounds = false
        medianImageView3.clipsToBounds = true
        medianImageView3.contentMode = .ScaleAspectFill
        medianImageView3.image = UIImage(named: "im3.jpg")
        
        medianImageView4.layer.borderColor = UIColor.redColor().CGColor
        medianImageView4.layer.borderWidth = 1.0
        medianImageView4.layer.masksToBounds = false
        medianImageView4.clipsToBounds = true
        medianImageView4.contentMode = .ScaleAspectFill
        medianImageView4.image = UIImage(named: "im4.jpg")
        
        medianImageView5.layer.borderColor = UIColor.redColor().CGColor
        medianImageView5.layer.borderWidth = 1.0
        medianImageView5.layer.masksToBounds = false
        medianImageView5.clipsToBounds = true
        medianImageView5.contentMode = .ScaleAspectFill
        medianImageView5.image = UIImage(named: "im5.jpg")
        
        
        
        
// search Bar
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            myTableVIew.tableHeaderView = controller.searchBar
            
            return controller
        })()
        

        
        myTableVIew.reloadData()
        
        if((contentFlag) == true)
        {
            contentTitleLable.text = contentTitle
        }
        
        else
        {
            contentTitleLable.text = "Test"
        }
        
        
    }
    
    
    func imageTapped(gesture: UIGestureRecognizer)
    {
        print("tapped")
        
        

    }
  
    @IBOutlet weak var sendMessage: UIButton!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : CustomeCell = tableView.dequeueReusableCellWithIdentifier("cell") as! CustomeCell
        //var(PersonName)=peopleName[indexPath.row] // Un comment Thnis
        var PersonName = String()
        var profPic = profilepic[indexPath.row]
        var viewCount = totalViews[indexPath.row]
        cell.profileImage.layer.borderWidth = 1.0
        cell.profileImage.layer.masksToBounds = false
        cell.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        cell.profileImage.layer.cornerRadius =   cell.profileImage.frame.size.height/2
        cell.profileImage.clipsToBounds = true
        cell.profileImage.contentMode = .ScaleAspectFill
        
        cell.profileImage.image=UIImage(named :profPic )
        
        
//        cell.participantName.text = PersonName  // Uncomment
        cell.viewsLable.text = String(viewCount) + " Views"

        
        if (self.resultSearchController.active) {
            cell.participantName.text = filteredPeople[indexPath.row]
            imagess = cell.profileImage.image
            return cell
        }
        else {
           cell.participantName.text = peopleName[indexPath.row]
            imagess = cell.profileImage.image
            return cell
        }
        
        
        imagess = cell.profileImage.image

       // return cell  // un coment

        
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         if (self.resultSearchController.active) {
            
           return filteredPeople.count
        }
        
        else
        {
        return peopleName.count
        }
        
        
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
            {
                peopleName.removeAtIndex(indexPath.row)
                tableView.reloadData()
        }
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        myTableVIew.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredPeople.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (peopleName as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredPeople = array as! [String]
        
        myTableVIew.reloadData()
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        if(segue.identifier == "viewMedia")
        {
            let destinationVC = segue.destinationViewController as! MediaView
            //destinationVC.mediaImage = medianImageView1
            destinationVC.img = "1.jpg"
            destinationVC.mediaImage = medianImageView1.image
            
        }
        
        if(segue.identifier == "contactContentInfo")
        {
            let destinationVC = segue.destinationViewController as! ContactContentView
            //destinationVC.proImg = medianImageView1.image
            destinationVC.proImg = imagess
           destinationVC.proImgName = profilepic[2]
           
          //let cell : CustomeCell = tableView.dequeueReusableCellWithIdentifier("cell") as! CustomeCell
        //destinationVC.proImg = cell.profileImage.image
        }
        
          if(segue.identifier == "editName")
          {
            let destinationVC = segue.destinationViewController as! editNameInfo
            destinationVC.prevName = contentTitleLable.text
            
          }
        if (segue.identifier == "showContactDetail")
        {
            let destinationVC : showContactDetails = segue.destinationViewController as! showContactDetails
            destinationVC.profilePic = UIImage(named: "1.jpg")
            destinationVC.nameLabel = "userName"
        }
    
      
        
    contentTitleLable.text = contentTitle
    }
    // Sending Message
    
    @IBAction func sendText(sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = ["9" , "8"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
        else
        {
            
            print("cant send a msg")
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
}

