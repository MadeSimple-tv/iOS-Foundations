//
//  AudioService.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/11/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioServiceDelegate{
    func songIsPlaying(currentTime: Double, duration: Double)
}

class AudioService{
    static let shared = AudioService()

    var timer: Timer?
    var delegate: AudioServiceDelegate?
    var audioPlayer: AVAudioPlayer!
    let songs = ["song-0", "song-1", "song-2"]
    
    private init(){}
    
    func play(song: Song){
        let randomSong = songs.randomElement()!
        let songUrl = Bundle.main.url(forResource: randomSong, withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOf: songUrl)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        startTimer()
    }
    
    func play(atTime time: Double){
        audioPlayer.currentTime = time
    }
    
    func pause(){
        audioPlayer.pause()
        stopTimer()
    }
    
    func resume(){
        audioPlayer.play()
        startTimer()
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (time) in
            self.delegate?.songIsPlaying(currentTime: self.audioPlayer.currentTime, duration: self.audioPlayer.duration)
        })
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
}
