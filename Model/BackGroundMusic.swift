//
//  BackGroundMusic.swift
//  AppyStoreBLZ
//
//  Purpose : Creating a singleton class to play background music
//
//  Created by Lokesh Kumar on 17/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import AVFoundation

class BackGroundMusic {
    static let sharedPlayer = BackGroundMusic()
    var backgroundMusicPlayer : AVAudioPlayer?
    
    func backGroundMusic() {
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
            print("cannot play")
        }
    }
    
    func playMusic() {
        
        backgroundMusicPlayer?.play()
        
    }
    
    func pauseMusic()  {
        
        backgroundMusicPlayer?.pause()
        
    }
}
