//
//  TrackPlayerViewController.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 11/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import AVKit


class TrackPlayerViewController: UIViewController {
    
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    @IBOutlet weak var playStateButton: UIButton!
    
    @IBAction func sliderTouchedDown(_ sender: Any) {
        self.timer.invalidate()
        self.player.pause()
    }
    
    @IBOutlet weak var trackDuration: UILabel!
    @IBOutlet weak var currentDuration: UILabel!
    @IBAction func trackSliderValueChanged(_ sender: Any) {
        if let _ = player.currentItem{
            let seektime = CMTimeMake(Int64(self.trackSlider.value), 1);
            self.player.currentItem?.seek(to: seektime, completionHandler:{ (params) -> Void in
                self.initUpdateTimer()
                self.player.play()
            })
        }
    }
    @IBOutlet weak var stopStateButton: UIButton!
    @IBOutlet weak var trackSlider: UISlider!
    
    @IBAction func playPressedEvent(_ sender: Any) {
        self.playPressed()
    }
    
    @IBAction func PausePressedEvent(_ sender: Any) {
        self.pausePressed()
    }
    
    public var currentSongModel:SongModel?
    private var player = AVPlayer()
    private var timer = Timer()
    private var isNeedToSetSliderMaxValueAndTrackDuration:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initArtwork()
        self.initSongDescriptionFields()
        if let previewUrl = currentSongModel?.previewUrl,let playerItem = self.initPlayerItem(previewUrl){
                self.initPlayer(playerItem)
        }else{
//            show error
            self.playStateButton.isEnabled = false
        }
        self.initUpdateTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    private func initUpdateTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateScreen), userInfo: nil, repeats: true)
    }
    
    private func initArtwork(){
        self.artworkImage.kf.indicatorType = .activity
        if let artworkPath = currentSongModel?.artworkUrl100{
            if let artworkUrl = URL(string:artworkPath){
                self.artworkImage.kf.setImage(with: artworkUrl)
            }
        }
    }
    
    private func initSongDescriptionFields(){
        self.artist.text = self.currentSongModel?.artistName
        self.songName.text = self.currentSongModel?.trackName
    }
    
    private func initPlayerItem(_ songPath:String)->AVPlayerItem?{
        if let songUrl = URL(string:songPath){
            let playerItem = AVPlayerItem(url:songUrl)
            return playerItem
        }
        return nil
    }
    
    private func initPlayer(_ playerItem:AVPlayerItem){
        self.player = AVPlayer(playerItem: playerItem)
    }
    
    private func playPressed(){
        if let _ = player.currentItem{
            player.rate = 1.0;
            player.play()
            stopStateButton.isHidden = false
            playStateButton.isHidden = true
        }
    }
    
    private func pausePressed(){
        if let _ = player.currentItem{
            player.pause()
            stopStateButton.isHidden = true
            playStateButton.isHidden = false
        }
    }
    
    private func convertToMinutesAndSeconds(time:CMTime?)->String{
        var resultString = ""
        if let timeInSeconds = time?.seconds{
            let seconds = Int(timeInSeconds) % 60
            let minutes = Int(timeInSeconds) % 3600 / 60
            let hours = Int(timeInSeconds) / 3600
            if (hours > 0 ){
                resultString.append(String(hours))
                resultString.append(":")
            }
            resultString.append(String(minutes))
            resultString.append(":")
            resultString.append((seconds<10) ? "0"+String(seconds) : String(seconds))
        }
        return resultString
    }
    
    @objc func UpdateScreen(){
        if (self.isNeedToSetSliderMaxValueAndTrackDuration){
            if let ci = self.player.currentItem,ci.status == .readyToPlay{
                self.isNeedToSetSliderMaxValueAndTrackDuration = false
                self.trackDuration.text = self.convertToMinutesAndSeconds(time: ci.duration)
                self.trackSlider.maximumValue = Float(TimeInterval(ci.duration.seconds))
            }
        }
        if let ciCurrentTime = self.player.currentItem?.currentTime(){
            self.trackSlider.value = Float(ciCurrentTime.seconds)
            if (self.trackSlider.maximumValue == self.trackSlider.value){
                if let previewUrl = currentSongModel?.previewUrl,let playerItem = self.initPlayerItem(previewUrl){
                    self.initPlayer(playerItem)
                    self.pausePressed()
                }
            }
            self.currentDuration.text = self.convertToMinutesAndSeconds(time: ciCurrentTime)
        }
    }
}

