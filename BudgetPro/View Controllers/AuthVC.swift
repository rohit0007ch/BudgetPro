//
//  MainVC.swift
//  BudgetPro
//
//  Created by ROHIT on 05/10/25.
//

import UIKit

class AuthVC: UIViewController {

    @IBOutlet weak var signupContainer: UIView!
    @IBOutlet weak var loginContainer: UIView!
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        // Default style
        segmentedControl.selectedSegmentIndex = 0
        setupSegmentControl()
        updateContainer(for: 0)
    }

    func setupSegmentControl() {
        let normalAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor.lightGray
        ]
        let selectedAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        segmentedControl.setTitleTextAttributes(normalAttrs, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttrs, for: .selected)
        segmentedControl.layer.cornerRadius = 8
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        updateContainer(for: sender.selectedSegmentIndex)
    }
    func updateContainer(for index: Int) {
        let fromView = index == 0 ? signupContainer! : loginContainer!
        let toView = index == 0 ? loginContainer! : signupContainer!
        
        let offset = index == 0 ? -30 : 30
        toView.transform = CGAffineTransform(translationX: CGFloat(offset), y: 0)
        toView.alpha = 0
        toView.isHidden = false
        
        UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseInOut], animations: {
            fromView.alpha = 0
            toView.alpha = 1
            toView.transform = .identity
        }) { _ in
            fromView.isHidden = true
            fromView.alpha = 1
        }
    }

}
