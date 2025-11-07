//
//  SecurityVC.swift
//  BudgetPro
//
//  Created by ROHIT on 03/11/25.
//

import UIKit

class SecurityVC: UIViewController {
    @IBOutlet weak var currentPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
setupPasswordField(currentPasswordField)
        setupPasswordField(newPasswordField)
        setupPasswordField(confirmPasswordField)
        
    }
    
    func setupPasswordField(_ textField: UITextField) {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 24)) // <- wider container = padding
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .white
        eyeButton.frame = CGRect(x: 8, y: 0, width: 24, height: 24) // x:8 adds inner padding
        
        eyeButton.tag = textField.hashValue
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
        container.addSubview(eyeButton)
        textField.rightView = container
        textField.rightViewMode = .always
    }

    @objc func togglePasswordVisibility(_ sender: UIButton) {
        // Find which text field this button controls
        let allFields = [currentPasswordField, newPasswordField, confirmPasswordField]
        
        for field in allFields {
            // Match the button tag with the field
            if field?.hashValue == sender.tag {
                guard let field = field else { return }
                
                // Toggle password visibility
                field.isSecureTextEntry.toggle()
                
                // Update the button icon
                let iconName = field.isSecureTextEntry ? "eye.slash" : "eye"
                sender.setImage(UIImage(systemName: iconName), for: .normal)
                
                // Fix text jump issue (refresh text)
                let text = field.text
                field.text = nil
                field.text = text
            }
        }
    }

    

    }


