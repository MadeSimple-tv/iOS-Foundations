//
//  ViewController.swift
//  Audio
//
//  Created by Lee Bennett on 1/9/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            let songPath = Bundle.main.path(forResource: "free-song", ofType: "mp3")!
            let songUrl = URL(fileURLWithPath: songPath)
            audioPlayer = try AVAudioPlayer(contentsOf: songUrl)
            audioPlayer.prepareToPlay()
        } catch{
            print("something went wrong with initializing audio player \(error.localizedDescription)")
        }
       
    }
    
    @IBAction func playButtonDidTapped(_ sender: UIButton) {
        audioPlayer.play()
    }
    
    @IBAction func pauseButtonDidTapped(_ sender: UIButton) {
        audioPlayer.pause()
    }
    
}

