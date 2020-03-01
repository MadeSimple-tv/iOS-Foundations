//
//  SongViewController.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/12/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {
    
    var album: Album!
    var selectedSongIndex: Int!
    var albumPrimaryColor: CGColor!
    var userStartedSliding = false
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Add gradient to background
        let backgroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [albumPrimaryColor, backgroundColor]
        gradientLayer.locations = [0.0, 0.4]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        thumbnailImageView.image = UIImage(named: "\(album.image)-lg")
        
        trackSlider.value = 0
        currentTimeLabel.text = "00:00"
        playButton.layer.cornerRadius = playButton.frame.size.width / 2.0
        
        AudioService.shared.delegate = self
        
        updateFavoriteButton()
        
        playSelectedSong()
    }
    
    func updateFavoriteButton(){
        let songSelected = album.songs[selectedSongIndex]
        if UserService.shared.isFavoritedSong(song: songSelected){
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        } else{
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    private func playSelectedSong(){
        let songSelected = album.songs[selectedSongIndex]
        
        titleLabel.text = songSelected.title
        artistLabel.text = songSelected.artist
        AudioService.shared.play(song: songSelected)
    }
    
    @IBAction func dismissButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        AudioService.shared.pause()
    }
    
    @IBAction func favoriteButtonDidTapped(_ sender: UIButton) {
        let songSelected = album.songs[selectedSongIndex]

        if UserService.shared.isFavoritedSong(song: songSelected){
            UserService.shared.unfavoriteSong(song: songSelected)
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        } else{
            UserService.shared.favoriteSong(song: songSelected)
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        }
    }
    
     // By default, the slider sends value-changed events continuously as the user moves the slider’s thumb control. Setting the isContinuous property to false causes the slider to send an event only when the user releases the slider’s thumb control, setting the final value.
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        if sender.isContinuous{
            userStartedSliding = true
            sender.isContinuous = false
        } else{
            userStartedSliding = false
            AudioService.shared.play(atTime: Double(sender.value))
            sender.isContinuous = true
        }
    }
    
    @IBAction func previousButtonDidTapped(_ sender: UIButton) {
        selectedSongIndex = max(0, selectedSongIndex - 1)
        updateFavoriteButton()
        playSelectedSong()
    }
    
    @IBAction func playButtonDidTapped(_ sender: UIButton) {
        let TAG_PAUSE = 0
        let TAG_PLAY = 1
        
        // If tag is 0, pause the music
        if sender.tag == TAG_PAUSE{
            AudioService.shared.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
            sender.tag = TAG_PLAY
        } else if sender.tag == TAG_PLAY{
            AudioService.shared.resume()
            sender.setImage(UIImage(named: "pause"), for: .normal)
            sender.tag = TAG_PAUSE
        }
    }
    
    @IBAction func nextButtonDidTapped(_ sender: UIButton) {
        selectedSongIndex = (selectedSongIndex + 1) % album.songs.count
        // 5 % 5 = 0
        // 1 % 5 = 1
        updateFavoriteButton()
        playSelectedSong()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SongViewController: AudioServiceDelegate{
    func songIsPlaying(currentTime: Double, duration: Double) {
        trackSlider.maximumValue = Float(duration)
        
        if !userStartedSliding{
            trackSlider.value = Float(currentTime)
        }
        
        // Update current time + duration labels (i.e. 12:01)
        currentTimeLabel.text = stringFromTime(time: currentTime)
        durationLabel.text = stringFromTime(time: duration)
    }
    
    func stringFromTime(time: Double) -> String{
        let seconds = Int(time) % 60
        let minutes = (Int(time) / 60) % 60
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
}
