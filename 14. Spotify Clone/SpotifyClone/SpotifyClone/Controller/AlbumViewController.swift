//
//  AlbumViewController.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/10/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit
import UIImageColors

class AlbumViewController: UIViewController {

    var album: Album!
    var albumPrimaryColor: CGColor!
    @IBOutlet weak var thumbnailImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thumbnailImageVIew.image = UIImage(named: album.image)
        titleLabel.setTitle(album.name, for: .normal)
        descriptionLabel.text = "\(album.followers) followers - by \(album.artist)"
        
        if UserService.shared.isFollowingAlbum(album: album){
            // set button text to "following" with a green color
            followButton.setTitle("Following", for: .normal)
            followButton.layer.borderColor = UIColor(red: 42.0 / 255.0, green: 183.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0).cgColor
        } else{
            followButton.setTitle("Follow", for: .normal)
            followButton.layer.borderColor = UIColor.white.cgColor
        }
        
        // Rounded corners and white border
        shuffleButton.layer.cornerRadius = 10.0
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderWidth = 1.0
        
        thumbnailImageVIew.image?.getColors{ colors in
            self.albumPrimaryColor = colors!.primary.withAlphaComponent(0.8).cgColor
            self.updateBackground(with: self.albumPrimaryColor)
        }
        
    }

    func updateBackground(with color: CGColor){
        let backgroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [backgroundColor, backgroundColor]
        gradientLayer.locations = [0.0, 0.4]
        
        let gradientChangeColor = CABasicAnimation(keyPath: "colors")
        gradientChangeColor.duration = 0.5
        gradientChangeColor.toValue = [color, backgroundColor]
        gradientChangeColor.isRemovedOnCompletion = false
        gradientChangeColor.fillMode = .forwards
        gradientLayer.add(gradientChangeColor, forKey: "colorChange")
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func backButtonDidTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func followButtonDidTapped(_ sender: UIButton) {
        // Check to see if the user is following the album
        if UserService.shared.isFollowingAlbum(album: album){
            // If our user is, then unfollow the album
            UserService.shared.unfollowAlbum(album: album)
            followButton.setTitle("Follow", for: .normal)
            followButton.layer.borderColor = UIColor.white.cgColor
        } else{
            // If our user is not, then follow the album
            UserService.shared.followAlbum(album: album)
            followButton.setTitle("Following", for: .normal)
            followButton.layer.borderColor = UIColor(red: 42.0 / 255.0, green: 183.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0).cgColor
        }
        
        descriptionLabel.text = "\(album.followers) followers - by \(album.artist)"
    }
    
    @IBAction func shuffleButtonDidTapped(_ sender: UIButton) {
        let randomIndex = Int(arc4random_uniform(UInt32(album.songs.count)))
        performSegue(withIdentifier: "SongSegue", sender: randomIndex)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let songViewController = segue.destination as? SongViewController, let selectedSongIndex = sender as? Int{
            songViewController.album = album
            songViewController.selectedSongIndex = selectedSongIndex
            songViewController.albumPrimaryColor = albumPrimaryColor
        }
    }
    

}

extension AlbumViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        let song = album.songs[indexPath.row]
        cell.update(song: song)
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SongSegue", sender: indexPath.row)
    }
}
