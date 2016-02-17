//
//  CustomeCell.swift
//  Content_Info_SP
//
//  Created by Vidya Ramamurthy on 25/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class CustomeCell: UITableViewCell{

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var participantName: UILabel!
    
    @IBOutlet weak var viewsLable: UILabel!
    
    @IBAction func button(sender: AnyObject) {
        
        
        
    }
    
    
    // For COntactConetntcView
    
    
    @IBOutlet weak var actionLable: UILabel!
    @IBOutlet weak var openedLabel: UILabel!
    
    @IBAction func sendMessage(sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func longPressed(sender: UILongPressGestureRecognizer)
    {
        print("longpressed")
        //Different code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
