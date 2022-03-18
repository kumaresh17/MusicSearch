//
//  ExtensionHelper.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation
import UIKit


/// A Helper to remove view from the superview
extension UIView {
    func remove() {
        self.removeFromSuperview()
    }
}

/// Extension of UIApplication to get the connected scene
extension UIApplication {
    var keyWindow: UIWindow? {
        /// Get connected scenes
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}


/// Date extension to check for invalid data
extension Data {
    func isInValid() -> Bool {
        return self.count > 40 ? false : true
    }
}

/// Date extension to check for eempty data
extension Data {
    func isEmptyData() -> Bool {
        return self.count == 0 ? true : false
    }
}

/// An image view extension to download image
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

