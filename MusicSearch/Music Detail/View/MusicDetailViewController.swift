//
//  MusicDetailViewController.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import UIKit

class MusicDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var musicResponseProtocol: MusicResponseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Music details"
        titleLabel.text = musicResponseProtocol?.title
        nameLabel.text = musicResponseProtocol?.name
        
        guard let imageUrl = URL(string: (musicResponseProtocol?.images?[3].url)!) else { return }
        imageView.load(url: imageUrl)
    }

}