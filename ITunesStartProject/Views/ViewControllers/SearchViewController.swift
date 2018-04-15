//
//  ViewController.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 11/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import UIKit
import PKHUD

protocol SearchViewControllerType: class {
    func updateSongModels(songModels:[SongModel])
    func hideHUD()
    func showProgress()
}
class SearchViewController: UIViewController,SearchViewControllerType,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyListPlaceholder: UILabel!
    
    lazy var presenter : ITunesSearchPresenterType = try! (UIApplication.shared.delegate as! AppDelegate).di.resolve(arguments: self as SearchViewControllerType)
    private let cellId = "songTableViewCellIdentifier"
    private var songsData:[SongModel] = []
    private var selectedSongModel:SongModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.selectedSongModel = nil
    }
    
    //    Table Data delegate and datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSongModel = songsData[indexPath.row]
        performSegue(withIdentifier: "showDetailSongPageSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let songCell = cell as? SearchTableViewCell{
            songCell.artistName.text = songsData[indexPath.row].artistName
            songCell.trackName.text = songsData[indexPath.row].trackName
            if let artworkPath:String = songsData[indexPath.row].artworkUrl100{
                if let url = URL(string:artworkPath){
                    songCell.artwork.kf.setImage(with: url)
                }
            }
        }
        return cell
    }
    
    //    HUD
    func showProgress(){
        HUD.show(.progress)
    }
    
    func hideHUD(){
        HUD.hide()
    }
    
    //    SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.count >= 5){
            self.emptyListPlaceholder.isHidden = true;
            self.songsTableView.isHidden = false;
            presenter.showSongs(searchString: searchBar.text!, fresh: false)
        } else {
            self.emptyListPlaceholder.isHidden = false;
            self.songsTableView.isHidden = true;
        }
    }

    func updateSongModels(songModels:[SongModel]){
        self.songsData = songModels
        self.songsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSongPageSegue"{
            if let dest = segue.destination as? TrackPlayerViewController{
                dest.currentSongModel = self.selectedSongModel
            }
        }
    }
    
}

