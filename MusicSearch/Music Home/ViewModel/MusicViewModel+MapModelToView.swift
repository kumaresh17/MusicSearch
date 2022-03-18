//
//  MusicViewModel+MapToView.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 17/03/2022.
//

import Foundation

/**
 Mapping  Album, Artist and Tracks array of Concret Object to MusicResponseProtocol
 Avoid using concrete Codable objects directly, instead used a ResponseProtocol
 Prepare Data which is required to display on the View
 */

extension MusicViewModel {
    
    // Album
    func mapAlbumToViewModelProtocol(musicList:[Albums]) -> [MusicResponseProtocol]? {
        
        var result:[MusicResponseProtocol]? = [MusicResponseProtocol]()
        _ = musicList.map {
            let response = MusicResponse(title: $0.title, name: $0.name, images:$0.images)
            result?.append(response)
        }
        return result
    }
    
   // Track
    func mapTrackToViewModelProtocol(musicList:[Tracks]) -> [MusicResponseProtocol]? {
        
        var result:[MusicResponseProtocol]? = [MusicResponseProtocol]()
        _ = musicList.map {
            let response = MusicResponse(title: $0.title, name: $0.name, images: $0.images)
            result?.append(response)
        }
        return result
    }
    
    //Artist
    func mapArtistToViewModelProtocol(musicList:[Artist]) -> [MusicResponseProtocol]? {
        
        var result:[MusicResponseProtocol]? = [MusicResponseProtocol]()
        _ = musicList.map {
            let response = MusicResponse(title: $0.title, name: $0.name, images:$0.image)
            result?.append(response)
        }
        return result
    }
    
   
    
   
    
  
}
