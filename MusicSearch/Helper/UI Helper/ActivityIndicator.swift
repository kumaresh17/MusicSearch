//
//  ActivityIndicator.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import UIKit

/**
 Activity indicator helper
 */
struct ActivityIndicator {
    
    static var spinner: UIActivityIndicatorView?
    static func showActivityIndicator(view:UIView) {
        
        spinner = UIActivityIndicatorView(style: .large)
        spinner?.translatesAutoresizingMaskIntoConstraints = false
        spinner?.startAnimating()
        guard let spinner = spinner else {return}
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    static func stopActivityIndicator() {
        spinner?.stopAnimating()
        /// UiView extesion
        spinner?.remove()
    }
}


