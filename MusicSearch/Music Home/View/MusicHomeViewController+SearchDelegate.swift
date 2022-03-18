//
//  MusicHomeViewControllerSearchDelegate.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation
import UIKit

/***
 Search Bar Delegate Methods
*/
extension MusicHomeViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            type = .album
        case 1:
            type = .track
        default:
            type = .artist
        }
        checkAndRequestMusicList(searchBar)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        checkAndRequestMusicList(searchBar)
    }
    
   private func checkAndRequestMusicList(_ searchBar: UISearchBar) -> Void {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, text.count < 20  else {
            return AlertViewController.showAlert(withTitle: "Music list", message: "Search text can not be more than 20 characters")
        }
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        ActivityIndicator.showActivityIndicator(view: self.view)
        
        ///Make sure to escape string, in case of empty space we need to escape the string to let it work
        guard let escapedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        musicViewModel?.getMusic(forType: type, withSearchText: escapedString)
    }
}
