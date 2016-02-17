//
//  MediaView.swift
//  Content_Info_SP
//
//  Created by Vidya Ramamurthy on 28/01/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class MediaView: UIViewController {
var mediaImage : UIImage!
    
    @IBOutlet weak var medianImageViewT1: UIImageView!
    var img : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        medianImageViewT1.layer.borderColor = UIColor.redColor().CGColor
        medianImageViewT1.layer.borderWidth = 1.0
        medianImageViewT1.layer.masksToBounds = false
        medianImageViewT1.clipsToBounds = true
        medianImageViewT1.contentMode = .ScaleAspectFill
        
        medianImageViewT1.image = mediaImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
