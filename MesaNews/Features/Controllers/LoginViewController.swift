//
//  ViewController.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 13/04/21.
//

import UIKit
import SwiftKeychainWrapper

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: MSTextField!
    @IBOutlet private weak var passwordTextField: MSTextField!
    @IBOutlet private weak var signinButton: UIButton!
    
    private var viewModel: LoginViewModel!
    private var kvo: NSKeyValueObservation?
    
    @IBAction func accessUserView(_ sender: UIButton) {
        clearFields()
        performSegue(withIdentifier: "CreateUserSegue", sender: nil)
    }
    
    @IBAction func accessNews(_ sender: UIButton) {
        self.showSpinner(onView: self.view)
        viewModel.sendLogin()
    }
}

// MARK: Life cycle
extension LoginViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        sendToNewsController()
        
        viewModel = LoginViewModel(login: .init(email: "", password: ""))
        viewModel.delegate = self
        
        kvo = viewModel.observe(\.isValid, options: [.initial, .new]) { viewModel, change in
            self.signinButton.isEnabled = viewModel.isValid
            Utils.configButton(self.signinButton)
        }
        
        signinButton.layer.cornerRadius = 20.0
        configureTextFields()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
}

// MARK: Helpers
extension LoginViewController {
    
    private func configureTextFields() {
        
        let emailPresset = DefaultTextField(text: "",
                                            placeholder: "E-mail",
                                            contentType: .emailAddress,
                                            keyboardType: .emailAddress,
                                            textAccessibilityLabel: "Text Field E-mail")
        
        emailTextField.configureTextField(presset: emailPresset)
        emailTextField.delegate = self
        
        let passwordPresset = DefaultTextField(text: "",
                                               placeholder: "Password",
                                               contentType: .password,
                                               keyboardType: .alphabet,
                                               textAccessibilityLabel: "Text Field Password")
        
        passwordTextField.configureTextField(presset: passwordPresset)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
    }
    
    private func clearFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        viewModel.email = ""
        viewModel.password = ""
        viewModel.validate()
    }
    
    private func sendToNewsController() {
        guard let _ = KeychainWrapper.standard.string(forKey: "token") else { return }
        self.performSegue(withIdentifier: "NewsSegue", sender: nil)
    }
    
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let tag = textField.tag
        
        if emailTextField.tag == tag {
            
            if let email = emailTextField.text, !email.isEmpty {
                
                if Utils.isValidEmail(email) {
                    
                    viewModel.email = email
                    
                } else {
                    
                    Utils.message(title: "E-mail",
                                  message: "Invalid format",
                                  error: true,
                                  view: self,
                                  completion: nil)
                }
            }
        }
        
        if passwordTextField.tag == tag {
            
            if let password = passwordTextField.text, !password.isEmpty {
                
                viewModel.password = password
                
            }
        }
        
        viewModel.validate()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let tag = textField.tag + 1
        
        if emailTextField.tag == tag {
            emailTextField.becomeFirstResponder()
        }
        
        if passwordTextField.tag == tag {
            passwordTextField.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}

// MARK: LoginViewControllerDelegate
extension LoginViewController: LoginViewControllerDelegate {
    func getInformationBack(data: String?) {
        
        self.removeSpinner()
        
        if let result = data {
            
            clearFields()
            KeychainWrapper.standard.set(result, forKey: "token")
            self.performSegue(withIdentifier: "NewsSegue", sender: nil)
            
        } else {
            
            Utils.message(title: "Error!",
                          message: "Ivalid e-mail or password",
                          error: true,
                          view: self, completion: nil)
        }
    }
}

