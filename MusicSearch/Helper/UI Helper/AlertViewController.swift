//
//  AlertViewController.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import UIKit

protocol AlertDelegate: AnyObject {
    func alert(buttonClickedIndex:Int, buttonTitle: String, tag: Int)
}

class AlertViewController {
    class func showAlert(withTitle title: String, message:String, buttons:[String] = [NSLocalizedString("Ok", comment: "")], delegate: AlertDelegate? = nil, tag: Int = 0){
        let keyWindow = UIApplication.shared.keyWindow
        
        var presentingViewController = keyWindow?.rootViewController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tag = tag
        var index = 0
        for button in buttons {
            let action =  UIAlertAction(title: button, style: .default, handler: { (alertAction) in
                
                if let d = delegate{
                    d.alert(buttonClickedIndex: index, buttonTitle: alertAction.title != nil ? alertAction.title! : title, tag: tag)
                }
            })
            alert.addAction(action)
            index = index + 1
        }
        
        while presentingViewController?.presentedViewController != nil {
            presentingViewController = presentingViewController?.presentedViewController
        }
        
        presentingViewController?.present(alert, animated: true, completion: nil)
    }
}



