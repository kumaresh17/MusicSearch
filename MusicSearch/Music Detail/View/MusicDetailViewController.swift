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
        self.navigationItem.title = NSLocalizedString("Musicdetails", comment: "")
        titleLabel.text = musicResponseProtocol?.title
        nameLabel.text = musicResponseProtocol?.name
        
        guard let count = musicResponseProtocol?.images?.count else {return}
        
        if (count != 0) {
            guard let musicImage = musicResponseProtocol?.images?[count - 1] else {return}
            guard let imageUrl = URL(string: musicImage.url) else {return}
            imageView.load(url: imageUrl)
        }
    }
    
    
    

}
