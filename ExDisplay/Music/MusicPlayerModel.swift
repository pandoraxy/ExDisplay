//
//  MusicPlayerModel.swift
//  ExDisplay
//
//  Created by lihao on 16/4/22.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicPlayerModel: NSObject {
    //MARK: - Properties
    var mediaQuery: MPMediaQuery
    
    //MARK: - LifeCycle
    override init() {
        mediaQuery = MPMediaQuery.songsQuery()
    }
    
    //MARK: - Custom Accessors
    
    //MARK: - IBActions
    
    //MARK: - Public
    func musicMediaItemCollectionWithMediaGrouping(mediaGrouping: MPMediaGrouping) -> MPMediaItemCollection {
        var mediaCollection: MPMediaItemCollection = MPMediaItemCollection.init(items: [MPMediaItem]())
        switch mediaGrouping {
        case .Album:
            mediaQuery = MPMediaQuery.albumsQuery()
            mediaQuery.groupingType = .Album
        case .Artist:
            mediaQuery = MPMediaQuery.artistsQuery()
            mediaQuery.groupingType = .Artist
        case .AlbumArtist:
            mediaQuery = MPMediaQuery.artistsQuery()
            mediaQuery.groupingType = .AlbumArtist
        case .Playlist:
            mediaQuery = MPMediaQuery.playlistsQuery()
            mediaQuery.groupingType = .Playlist
        case .Title:
            mediaQuery = MPMediaQuery.songsQuery()
            mediaQuery.groupingType = .Title
        case .Composer:
            mediaQuery = MPMediaQuery.composersQuery()
            mediaQuery.groupingType = .Composer
            break
        case .Genre:
            mediaQuery = MPMediaQuery.genresQuery()
            mediaQuery.groupingType = .Genre
            break
        case .PodcastTitle:
            mediaQuery = MPMediaQuery.podcastsQuery()
            mediaQuery.groupingType = .PodcastTitle
            break
            
        }
        
        //        let colletions = mediaQuery.collections
        //        if colletions?.count > 0 {
        //            mediaCollections = colletions! as [MPMediaItemCollection]
        //        }
        
        let items:[MPMediaItem] = mediaQuery.items!
        if items.count > 0 {
            mediaCollection = MPMediaItemCollection.init(items: items)
        }
        
        return mediaCollection
    }
    
    func filterMediaCollectionsForAlbum(albumTitle: String?, albumPersistentID albumID: NSNumber?, albumArtist artist: String?) -> [MPMediaItemCollection] {
        var albumTitleFilter: MPMediaPropertyPredicate
        var albumIdFilter: MPMediaPropertyPredicate
        var albumArtistFilter: MPMediaPropertyPredicate
        var mediaCollections: [MPMediaItemCollection] = [MPMediaItemCollection]()
        
        if albumTitle!.isEmpty {
            albumTitleFilter = MPMediaPropertyPredicate.init(value: albumTitle, forProperty: MPMediaItemPropertyAlbumTitle)
            mediaQuery.addFilterPredicate(albumTitleFilter)
        }
        
        if (albumID != nil) {
            albumIdFilter = MPMediaPropertyPredicate.init(value: albumID, forProperty: MPMediaItemPropertyPersistentID)
            mediaQuery.addFilterPredicate(albumIdFilter)
        }
        
        if artist!.isEmpty {
            albumArtistFilter = MPMediaPropertyPredicate.init(value: artist, forProperty: MPMediaItemPropertyAlbumArtist)
            mediaQuery.addFilterPredicate(albumArtistFilter)
        }
        
        let filterCloudItem: MPMediaPropertyPredicate = MPMediaPropertyPredicate.init(value: NSNumber.init(bool: true), forProperty: MPMediaItemPropertyIsCloudItem)
        mediaQuery.addFilterPredicate(filterCloudItem)
        
        mediaQuery.groupingType = .Album
        
        let collections = mediaQuery.collections
        if (collections!.isEmpty) == false {
            mediaCollections = mediaQuery.collections!
        }
        
        return mediaCollections
    }
    
    func filterMediaCollectionsForArtist(artist: String?, albumArtist: String?) -> [MPMediaItemCollection] {
        var mediaCollections: [MPMediaItemCollection] = [MPMediaItemCollection]()
        
        var artistFilter: MPMediaPropertyPredicate?
        var albumArtistFilter: MPMediaPropertyPredicate?
        if artist != nil {
            artistFilter = MPMediaPropertyPredicate.init(value: artist, forProperty: MPMediaItemPropertyArtist)
            mediaQuery.addFilterPredicate(artistFilter!)
        }
        
        if albumArtistFilter != nil {
            albumArtistFilter = MPMediaPropertyPredicate.init(value: albumArtist, forProperty: MPMediaItemPropertyAlbumArtist)
            mediaQuery.addFilterPredicate(albumArtistFilter!)
        }
        
        let filterCloudItem: MPMediaPropertyPredicate = MPMediaPropertyPredicate.init(value: NSNumber.init(bool: true), forProperty: MPMediaItemPropertyIsCloudItem)
        mediaQuery.addFilterPredicate(filterCloudItem)
        
        let collections = mediaQuery.collections
        if (collections!.isEmpty) == false {
            mediaCollections = mediaQuery.collections!
        }
        mediaQuery.groupingType = .Artist
        
        return mediaCollections
    }
    
    //MARK: - Private
    private func removeAllMediaQueryFilterPredicate() {
        let filterPredicates = mediaQuery.filterPredicates
        if filterPredicates!.isEmpty {
            return
        }
        
        for filter in filterPredicates! {
            mediaQuery.removeFilterPredicate(filter)
        }
        
    }
    
    //MARK: - Protocol conformance
    
    //MARK: - iCarousel DataSource
}
