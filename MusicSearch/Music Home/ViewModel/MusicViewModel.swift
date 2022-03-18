//
//  MusicViewModel.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Combine

// MARK: - Music home viewmodel

protocol MusicViewModelProtocol {
    
    var dataForViewPub: Published<[MusicResponseProtocol]?>.Publisher { get }
    var errorPub: Published<Error?>.Publisher { get }
    func getMusic(forType:MusicType, withSearchText:String?) -> Void
}

final class MusicViewModel:MusicViewModelProtocol,PayLoadFormat {    
    
    /** Combine Publisher for which we have binded with FruitListViewController **/
    @Published var dataForView:[MusicResponseProtocol]?
    @Published var error:Error?
    var dataForViewPub: Published<[MusicResponseProtocol]?>.Publisher {$dataForView}
    var errorPub: Published<Error?>.Publisher {$error}
    
    private var networkManagerProtocol:NetworkManagerProtocol?
    private var apiModuleProtocol:APIModuleProtocol?
    
    /** Dependency injection with payloadData and Api manager so that we can perform unit test with Mock  data **/
    init(apiModule:APIModuleProtocol,networkManager:NetworkManagerProtocol) {
        self.apiModuleProtocol = apiModule
        self.networkManagerProtocol = networkManager
    }
    
    /** This convenince int will be called from the view with default parameters set for desiginated initializer **/
    convenience init () {
        self.init(apiModule: APIModule(searchType: .album, payloadType: .requestMethodGET, searchText: nil), networkManager:NetworkManager())
    }
    
    func getMusic(forType type:MusicType, withSearchText searchText:String?) -> Void {
        
        self.apiModuleProtocol?.searchType = type
        self.apiModuleProtocol?.searchText = searchText
        guard let apiModuleProtocol = self.apiModuleProtocol else { return }
        guard let payload = formatGetPayload(url: .musicUrl, module: apiModuleProtocol) else { return }
        switch type {
        case .album:
            self.networkManagerProtocol?.getAlbumsInfo(payload: payload) { [weak self] result in
                switch result {
                case .success(let data):
                    guard let albums = data.albums.albumMatches.album else { self?.error = HandledError.noDataFound
                        return}
                    self?.dataForView = self?.mapAlbumToViewModelProtocol(musicList: albums)
                case .failure(let error):
                    self?.error = error
                }
            }
        case .artist:
            self.networkManagerProtocol?.getArtistInfo(payload: payload) { [weak self] result in
                switch result {
                case .success(let data):
                    guard let artists =  data.result.artistMatches.matches else { self?.error = HandledError.noDataFound
                        return  }
                    self?.dataForView = self?.mapArtistToViewModelProtocol(musicList: artists)
                case .failure(let error):
                    self?.error = error
                }
            }
        case .track:
            self.networkManagerProtocol?.getTrackInfo(payload: payload) { [weak self] result in
                switch result {
                case .success(let data):
                    guard let tracks = data.track.trackMatches.matches else { self?.error = HandledError.noDataFound
                        return  }
                    self?.dataForView = self?.mapTrackToViewModelProtocol(musicList: tracks)
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
