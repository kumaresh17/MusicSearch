//
//  MusicTableViewCell.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    static var cellIdentifier = "MusicTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Display data on table view cell
    ///
    /// - Parameter data: Results containing all info
    func displayData(musicResponse: MusicResponseProtocol) {
        if let title = musicResponse.title {
            nameLabel.text = title
        } else {
            nameLabel.text = "No Album"
        }
        if let name = musicResponse.name {
            artistLabel.text = name
        } else {
            artistLabel.text = "No Artist"
        }
    }

}
