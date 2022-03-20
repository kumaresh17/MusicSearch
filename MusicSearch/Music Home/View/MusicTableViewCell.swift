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
    func displayData(musicResponse: MusicResponseProtocol) {
        nameLabel.text = musicResponse.title ?? "No data"
        artistLabel.text = musicResponse.name ?? "No data"
    }

}
