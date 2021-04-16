//
//  UIViewController+extensions.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 15/04/21.
//

import UIKit

var spinnerLoad : UIView?

extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        spinnerLoad = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            spinnerLoad?.removeFromSuperview()
            spinnerLoad = nil
        }
    }
    
}
