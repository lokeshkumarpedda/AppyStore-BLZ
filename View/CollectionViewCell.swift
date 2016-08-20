//
//  CollectionViewCell.swift
//  AppyStoreBLZ
//  Puropse
//  1. This class have all variable of collection view cell
//  2. This class will display video image and respective names
//  2. This collection view cell is used but category,subcategory,search screen and history
//
//  Created by BridgeIt on 04/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var VideoImageView: UIImageView! //to display video image
    
    @IBOutlet weak var VideoLabel: UILabel! //to display video name
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! //to show video image loading
    
    @IBOutlet weak var VideoDurationLabel: UILabel!
    
    
    var imgUrl : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
