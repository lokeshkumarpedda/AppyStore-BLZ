//
//  editNameInfo.swift
//  Content_Info_SP
//
//  Created by Vidya Ramamurthy on 27/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class editNameInfo: UIViewController {

    
    
    @IBOutlet weak var ClickLable: UIButton!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var editNameTF: UITextField!
    var prevName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClickLable.layer.borderWidth = 0.5
        ClickLable.layer.borderColor = UIColor.grayColor().CGColor
        okButton.layer.borderWidth = 0.5
        okButton.layer.borderColor = UIColor.grayColor().CGColor
        
        
//        editNameTF.becomeFirstResponder()
//        
//        editNameTF.selectedTextRange = editNameTF.textRangeFromPosition(editNameTF.beginningOfDocument, toPosition: editNameTF.endOfDocument)
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: editNameTF.frame.size.height - width, width:  editNameTF.frame.size.width, height: editNameTF.frame.size.height)
        
        border.borderWidth = width
        editNameTF.layer.addSublayer(border)
        
        editNameTF.text = prevName
        editNameTF.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
         if(segue.identifier == "updateName")
         {
        let destinationVC = segue.destinationViewController as! ViewController
        destinationVC.contentTitle = editNameTF.text
            
          destinationVC.contentFlag = true
        }
        //print("hj", editNameTF.text)
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
