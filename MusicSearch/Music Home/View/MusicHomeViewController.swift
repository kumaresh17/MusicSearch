//
//  MusicHomeViewController.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import UIKit
import Combine

class MusicHomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var type: MusicType = .album
    var musicViewModel:MusicViewModelProtocol?
    var musicResponseProtocol: [MusicResponseProtocol]?
    
    /// To store the publisher stream, if we don't store,  it will not sink the stream and will be cancelled immediatelly.
    private var anyCancelable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        self.title = NSLocalizedString("Musicsearch", comment: "")
        musicViewModel = MusicViewModel()
        bindingOfViewWithViewModel()
    }
    
    /// Binding of View with ViewModel here Combine is used
   private func bindingOfViewWithViewModel() {
       musicViewModel?.dataForViewPub
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (dataView) in
                guard let dataView = dataView else {return}
                self?.musicResponseProtocol = dataView
                self?.tableView.reloadData()
                ActivityIndicator.stopActivityIndicator()
            }
            .store(in: &anyCancelable)
        
       musicViewModel?.errorPub
            .receive(on:DispatchQueue.main)
            .sink { (error) in
                guard let error = error else {return }
                AlertViewController.showAlert(withTitle:NSLocalizedString("Alert", comment: "") , message: error.localizedDescription)
                ActivityIndicator.stopActivityIndicator()
            }
            .store(in: &anyCancelable)
    }

}

