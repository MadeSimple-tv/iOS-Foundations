//
//  HomeViewController.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/10/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var categories: [Category]!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        categories = CategoryService.shared.categories
        
        navigationController?.isNavigationBarHidden = true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let albumViewController = segue.destination as? AlbumViewController, let album = sender as? Album{
            albumViewController.album = album
        }
    }
    

}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        let category = categories[indexPath.row]
        cell.update(category: category, index: indexPath.row)
        return cell
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categoryIndex = collectionView.tag
        let category = categories[categoryIndex]
        return category.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        let categoryIndex = collectionView.tag
        let category = categories[categoryIndex]
        let album = category.albums[indexPath.row]
        cell.update(album: album)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[collectionView.tag]
        let album = category.albums[indexPath.row]
        performSegue(withIdentifier: "AlbumSegue", sender: album)
    }
}
