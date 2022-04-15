//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Meredith Anderer on 4/14/22.
//

import UIKit

protocol ResultViewControllerProtocol {
    func dialogDismissed()
}

class ResultViewController: UIViewController {

    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    var delegate: ResultViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogView.layer.cornerRadius = 10.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Before the controller is displayed, update the text
        titleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
        
        // Hide UI Elements to start
        dimView.alpha = 0
        titleLabel.alpha = 0
        feedbackLabel.alpha = 0
        dismissButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Fade in the dim view
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations:
                {
                    self.dimView.alpha = 1
                    self.titleLabel.alpha = 1
                    self.feedbackLabel.alpha = 1
                },
            completion:
                { _ in
                    UIView.animate(
                        withDuration: 0.5,
                        delay: 0,
                        options: .curveEaseOut,
                        animations:
                            {
                                self.dismissButton.alpha = 1

                            },
                        completion: nil)
                }
        )
    }

    @IBAction func dismissTapped(_ sender: Any) {
        // Fade out the dim view before the popup is dismissed
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations:
                        {
                            self.dimView.alpha = 0
                        },
                       completion:
                        { _ in
                            // dismiss the popup
                            self.dismiss(animated: true, completion: nil)
                            // notify the delegate that it was dismissed
                            self.delegate?.dialogDismissed()
                        }
        )
    }
    
}
