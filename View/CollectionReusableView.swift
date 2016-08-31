//
//  CollectionReusableView.swift
//  AppyStoreApplication
//  Purpose
//  1. This class display header for search screen
//  2. Header contail few buttons for easy search for user
//  3. User can tab button for quick search
//
//  Created by Shelly on 26/07/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var RhymesLabel: UIButton!
    @IBOutlet weak var lettersLabel: UIButton!
    @IBOutlet weak var countingLabel: UIButton!
    @IBOutlet weak var drawingLabel: UIButton!
    @IBOutlet weak var scienceLabel: UIButton!
    @IBOutlet weak var numbersLabels: UIButton!
    @IBOutlet weak var puzzlesLabel: UIButton!
    @IBOutlet weak var ABCLabel: UIButton!
    @IBOutlet weak var readingLabel: UIButton!
    @IBOutlet weak var alplabetsLabel: UIButton!
    
    var searchViewObj : SearchBarViewController!

    @IBAction func buttonPressed(sender: UIButton) {
        searchViewObj = SearchBarViewController()

    }
    //setting border for buttons
    func mSetBorder () {
        RhymesLabel.layer.borderWidth = 2
        RhymesLabel.layer.cornerRadius = 5
        RhymesLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        lettersLabel.layer.borderWidth = 2
        lettersLabel.layer.cornerRadius = 5
        lettersLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        countingLabel.layer.borderWidth = 2
        countingLabel.layer.cornerRadius = 5
        countingLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        drawingLabel.layer.borderWidth = 2
        drawingLabel.layer.cornerRadius = 5
        drawingLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        scienceLabel.layer.borderWidth = 2
        scienceLabel.layer.cornerRadius = 5
        scienceLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        numbersLabels.layer.borderWidth = 2
        numbersLabels.layer.cornerRadius = 5
        numbersLabels.layer.borderColor = UIColor.whiteColor().CGColor
        
        puzzlesLabel.layer.borderWidth = 2
        puzzlesLabel.layer.cornerRadius = 5
        puzzlesLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        ABCLabel.layer.borderWidth = 2
        ABCLabel.layer.cornerRadius = 5
        ABCLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        readingLabel.layer.borderWidth = 2
        readingLabel.layer.cornerRadius = 5
        readingLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        alplabetsLabel.layer.borderWidth = 2
        alplabetsLabel.layer.cornerRadius = 5
        alplabetsLabel.layer.borderColor = UIColor.whiteColor().CGColor

        
    }
    

}
