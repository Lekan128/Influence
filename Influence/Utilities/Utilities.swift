//
//  Utilities.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 09/01/2023.
//

import UIKit

//MARK: - Alert and action sheet
func showDismissableAlert(with message : String, from controller : UIViewController) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { alertAction in
        print("Dismissed tapped")
    }))
    controller.present(alert, animated: true)
}

func showDismissableActionSheet(with message : String, from controller : UIViewController) {
    let actionSheet = UIAlertController(title: "Alert", message: message, preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { alertAction in
        print("Dismissed tapped")
    }))
    controller.present(actionSheet, animated: true)
}

//MARK: - instagram handle verificaton
func isValidHandle(instaHandle : String) -> Bool{
    //add a way to check if the insagram handle is valid
    if(instaHandle.isEmpty) {
        return false
    }
    return true
}

//MARK: - Activity Indicator
func stopLoading(activityIndicatorView indicator : UIActivityIndicatorView){
    indicator.isHidden = true
    indicator.stopAnimating()
}

func startLoading(activityIndicatorView indicator : UIActivityIndicatorView){
    indicator.isHidden = false
    indicator.startAnimating()
    
}
