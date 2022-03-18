//
//  MusicHomeViewController+Segue.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 17/03/2022.
//

import Foundation
import UIKit

extension MusicHomeViewController {
    
    /// Since it is a simple navigation to detail screen so using segue instead of router or coordinator design pattern
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? MusicTableViewCell else { return }
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        guard let detailView = segue.destination as? MusicDetailViewController else { return }
        guard let dataValue = self.musicResponseProtocol else { return }
        detailView.musicResponseProtocol = dataValue[index]
    }
}

