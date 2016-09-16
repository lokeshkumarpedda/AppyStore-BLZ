//
//  LoginViewController.swift
//  AppyStoreBLZ
//
//  Purpose
//  1 . This is login page
//  2 . User can enter their registered mobile no for login
//  3 . User can login without registeration also
//
//  Created by Shelly on 09/08/16.


//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController,UITextFieldDelegate {

    var mlocalDataBaseObj = LocalDataBase() //object of local database
    @IBOutlet weak var mobileNoTextField: UITextField!
    var backgroundMusicPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundMusic()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage")!)
        
        //to dismiss keyboard 
        mobileNoTextField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
    }
    
    func  dismissKeyboard() {
        mobileNoTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        mobileNoTextField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func playBackgroundMusic() {
        let url = NSBundle.mainBundle().URLForResource("background_music", withExtension: "mp3")
        if url == nil{
            print("music file not found")
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: url!)
            backgroundMusicPlayer!.numberOfLoops = -1
            backgroundMusicPlayer!.prepareToPlay()
            backgroundMusicPlayer!.play()
        }
        catch{
            
        }
//        let session:AVAudioSession = AVAudioSession.sharedInstance()
//        
//        do {
//            try session.setCategory(AVAudioSessionCategoryPlayback)
//        } catch {
//            //catching the error.
//        }
    }
    
    @IBAction func loginInWithMobileNoButton(sender: UIButton) {
    }

    @IBAction func loginInWithOutMobileNoButton(sender: UIButton) {
        performSegueWithIdentifier("LoginToCategory", sender: nil)
    }

}
