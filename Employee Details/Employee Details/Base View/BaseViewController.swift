//
//  BaseViewController.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: COMMON UIALERT
    //Common methodd for displaying alert
    final func showAlert(title: String, message: String, actionTitles: [String], actions: [((UIAlertAction) -> Void)?]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for (index,title) in actionTitles.enumerated() {
            let alertActions = UIAlertAction(title: title, style: .default, handler: actions[index])
            alertController.addAction(alertActions)
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: COMMON UIACTIVITY INDICATOR
    func showActivityIndicatorWithText(text: String) {
        
        let activityIndicatorView = UIActivityIndicatorView()

        let viewForActivityIndicator = UIView()
        let loadingTextLabel = UILabel()
        
        viewForActivityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        viewForActivityIndicator.backgroundColor = UIColor.white
        viewForActivityIndicator.alpha = 0.7
        self.view.addSubview(viewForActivityIndicator)
        self.view.isUserInteractionEnabled = false
        viewForActivityIndicator.tag = 34654

        activityIndicatorView.center = CGPoint(x: self.view.frame.size.width / 2.0, y: self.view.frame.size.height / 2.0)

        loadingTextLabel.textColor = UIColor.black
        loadingTextLabel.text = text
        loadingTextLabel.font = UIFont(name: "MyriadPro-Regular", size: 10)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y + 30)
        viewForActivityIndicator.addSubview(loadingTextLabel)

        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .medium
        viewForActivityIndicator.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

    func stopActivityIndicator() {
        DispatchQueue.main.async {
            if let viewToRemove = self.view.viewWithTag(34654){
                viewToRemove.removeFromSuperview()
            }
            self.view.isUserInteractionEnabled = true
        }
    }
}
