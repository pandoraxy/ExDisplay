//
//  MusicPlayer.swift
//  ExDisplay
//
//  Created by lihao on 16/4/22.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

protocol MusicPlayerDelegate : NSObjectProtocol {
    func musicPlayer(musicPlayer: MusicPlayer, updatePlaybackCurrentTime currentTime: NSTimeInterval, playbackDurationTime durationTime: NSTimeInterval)
    func musicPlayer(musicPlayer: MusicPlayer, didChangePlaybackState playbackState: MPMusicPlaybackState)
    func musicPlayer(musicPlayer: MusicPlayer, didChangeNowPlayingItem nowPlayingItem: MPMediaItem)
}

class MusicPlayer: NSObject {
    //MARK: - Properties
    private var audioPlayer: AVAudioPlayer
    private var musicPlayer: MPMusicPlayerController
    var musicShuffleMode: MPMusicShuffleMode
    var musicRepeatMode: MPMusicRepeatMode
    var timer: NSTimer!
    var musicPlayerModel: MusicPlayerModel!
    
    var playinMediaItem: MPMediaItem {
        return musicPlayer.nowPlayingItem!
    }
    
    weak var delegate: MusicPlayerDelegate?
    
    //MARK: - LifeCycle
    override init() {
        self.musicPlayer = MPMusicPlayerController.systemMusicPlayer()
        self.audioPlayer = AVAudioPlayer.init()
        self.musicShuffleMode = .Off
        self.musicRepeatMode = .Default
        
        super.init()
        
        self.initMusicPlayer()
        registerMediaPlayerNotifications()
    }
    
    //MARK: - Custom Accessors
    func registerMediaPlayerNotifications() {
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: #selector(handleNowPlayingItemChanged(_:)), name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: musicPlayer)
        notification.addObserver(self, selector: #selector(handlePlaybackStateChanged(_:)), name: MPMusicPlayerControllerPlaybackStateDidChangeNotification, object: musicPlayer)
        musicPlayer.beginGeneratingPlaybackNotifications()
    }
    
    //MARK: - IBActions
    //MARK: - NotificationHandlers
    func handleNowPlayingItemChanged(Notification: NSNotification) {
        delegate?.musicPlayer(self, didChangeNowPlayingItem: playinMediaItem)
    }
    
    func handlePlaybackStateChanged(Notification: NSNotification) {
        delegate?.musicPlayer(self, didChangePlaybackState: musicPlayer.playbackState)
    }
    
    //MARK: - Public
    func musicPlay() {
        musicPlayer.play()
    }
    
    func musicPause() {
        musicPlayer.pause()
    }
    
    func musicPlayNext() {
        let mediaItemCollection = musicPlayerModel.musicMediaItemCollectionWithMediaGrouping(.Title)
        if musicPlayer.indexOfNowPlayingItem == mediaItemCollection.count - 1 {
            return
        } else {
            musicPlayer.skipToNextItem()
        }
    }
    
    func musicPlayPrevious() {
        let mediaItemCollection = musicPlayerModel.musicMediaItemCollectionWithMediaGrouping(.Title)
        if musicPlayer.indexOfNowPlayingItem <= 0 || musicPlayer.indexOfNowPlayingItem > mediaItemCollection.count {
            return
        } else {
            musicPlayer.skipToPreviousItem()
        }
    }
    
    func setMediaPlayerWithItemCollection(itemCollection: MPMediaItemCollection?, nowPlayingItem playingItem: MPMediaItem?) -> Bool {
        
        if (itemCollection!.count == 0) && (playingItem == nil) {
            return false
        }
        
        if musicPlayer.playbackState == .Playing {
            musicPlayer.pause()
        }
        
        if itemCollection != nil {
            musicPlayer.setQueueWithItemCollection(itemCollection!)
        }
        musicPlayer.nowPlayingItem = playingItem
        musicPlayer.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        return true
    }
    
    //MARK: - Private
    private func initMusicPlayer() {
        if musicPlayer.playbackState == .Playing {
            musicPlayer.stop()
        }
        musicPlayer.shuffleMode = musicShuffleMode
        musicPlayer.repeatMode  = musicRepeatMode
        musicPlayerModel = MusicPlayerModel.init()
    }
    
    func updateTime() {
        delegate?.musicPlayer(self, updatePlaybackCurrentTime: musicPlayer.currentPlaybackTime, playbackDurationTime: (musicPlayer.nowPlayingItem?.playbackDuration)!)
    }
    
    //MARK: - Protocol conformance
}
