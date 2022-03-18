//
//  MusicHomeViewControllerDataSource.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation

import UIKit
import Foundation

// MARK: - Table data source delegates

extension MusicHomeViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.musicResponseProtocol?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.cellIdentifier, for: indexPath) as? MusicTableViewCell else {
            fatalError("no cell initialized")
        }
        guard let dataValue = self.musicResponseProtocol else {return cell}
        cell.displayData(musicResponse: dataValue[indexPath.row])
        
        return cell
    }
    
}
