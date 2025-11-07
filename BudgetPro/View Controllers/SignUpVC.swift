//
//  SignUpVC.swift
//  BudgetPro
//
//  Created by ROHIT on 05/10/25.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
     @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup email and password fields
        setupTextFields()
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.masksToBounds = true
        confirmpasswordTextField.layer.cornerRadius = 20
        confirmpasswordTextField.layer.masksToBounds = true
        
       
    }
    

     func setupTextFields() {
         // Left icons
         setLeftIcon(for: emailTextField, systemName: "envelope.fill")
         setLeftIcon(for: passwordTextField, systemName: "lock.fill")
         setLeftIcon(for: confirmpasswordTextField, systemName: "lock.fill")
         // Add show/hide password button
         addPasswordToggle(for: passwordTextField)
         addPasswordToggle(for: confirmpasswordTextField)

     }
     
     // MARK: - Helper: Add Left Icon
     func setLeftIcon(for textField: UITextField, systemName: String) {
         let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
         iconView.image = UIImage(systemName: systemName)
         iconView.tintColor = .systemGray2
         iconView.contentMode = .scaleAspectFit
         
         let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
         containerView.addSubview(iconView)
         
         textField.leftView = containerView
         textField.leftViewMode = .always
     }
     
     // MARK: - Helper: Add Right Eye Button for Password
     func addPasswordToggle(for textField: UITextField) {
         let button = UIButton(type: .custom)
         button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
         button.tintColor = .systemGray2
         button.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
         button.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
         
         textField.rightView = button
         textField.rightViewMode = .always
         textField.isSecureTextEntry = true
     }
     
     @objc func togglePasswordVisibility(_ sender: UIButton) {
         passwordTextField.isSecureTextEntry.toggle()
         confirmpasswordTextField.isSecureTextEntry.toggle()
         let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
         confirmpasswordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
         sender.setImage(UIImage(systemName: imageName), for: .normal)
     }
     
   
 }

