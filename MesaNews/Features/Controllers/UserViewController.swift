//
//  UserViewController.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 14/04/21.
//

import UIKit
import SwiftKeychainWrapper

final class UserViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: MSTextField!
    @IBOutlet private weak var emailTextField: MSTextField!
    @IBOutlet private weak var passwordTextField: MSTextField!
    @IBOutlet private weak var confirmPasswordTextField: MSTextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    private var kvo: NSKeyValueObservation?
    private var viewModel: UserViewModel!
    
    @IBAction private func save(_ sender: UIButton) {
        viewModel.sendUser()
    }
    
}

// MARK: Life cycle
extension UserViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTextFields()
        
        viewModel = UserViewModel(user: .init(name: "", email: "", password: ""))
        viewModel.userViewControllerDelegate = self
        
        kvo = viewModel.observe(\.isValid, options: [.initial, .new]) { viewModel, change in
            self.saveButton.isEnabled = viewModel.isValid
        }
        
    }
}

// MARK: UITextFieldDelegate
extension UserViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let tag = textField.tag
        
        if nameTextField.tag == tag {
            
            if let name = nameTextField.text {
                viewModel.name = name
            }
        }
        
        if emailTextField.tag == tag {
            
            if let email = emailTextField.text {
                
                if isValid(email) {
                    viewModel.email = email
                } else {
                    message(title: "E-mail", message: "Campo inválido", error: true)
                }
            }
        }
        
        if confirmPasswordTextField.tag == tag {
            
            guard let confirm = confirmPasswordTextField.text else { return }
            guard let pass = passwordTextField.text else { return }
            
            if !isAPasswordValid(password: pass, confirm: confirm) {
                message(title: "Senha", message: "Senha não são iguais", error: true)
            } else {
                viewModel.password = pass
            }
        }
        
        viewModel.validate()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let tag = textField.tag + 1
        
        if nameTextField.tag == tag {
            nameTextField.becomeFirstResponder()
        }
        
        if emailTextField.tag == tag {
            emailTextField.becomeFirstResponder()
        }
        
        if passwordTextField.tag == tag {
            passwordTextField.becomeFirstResponder()
        }
        
        if confirmPasswordTextField.tag == tag {
            confirmPasswordTextField.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}

// MARK: Helper
extension UserViewController {
    
    private func isValid(_ email: String) -> Bool {
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try? NSRegularExpression(pattern: TextFieldConstants.Regex.email)
        return regex?.firstMatch(in: email, options: [], range: range) != nil
        
    }
    
    private func isAPasswordValid(password: String, confirm: String) -> Bool {
        
        return password == confirm
        
    }
    
    private func message(title: String, message: String, error: Bool = false) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { action in
            if (!error) {
                self.viewModel = UserViewModel(user: .init(name: "", email: "", password: ""))
                self.clearFields()
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func configureTextFields() {
        
        let namePresset =  DefaultTextField(text: "",
                                            placeholder: "Nome completo",
                                            contentType: .name,
                                            keyboardType: .alphabet,
                                            textAccessibilityLabel: "Campo de texto Nome Completo")
        
        nameTextField.configureTextField(presset: namePresset)
        nameTextField.delegate = self
        
        let emailPresset = DefaultTextField(text: "",
                                            placeholder: "E-mail",
                                            contentType: .emailAddress,
                                            keyboardType: .emailAddress,
                                            textAccessibilityLabel: "Campo de texto E-mail")
        
        emailTextField.configureTextField(presset: emailPresset)
        emailTextField.delegate = self
        
        let passwordPresset = DefaultTextField(text: "",
                                               placeholder: "Senha",
                                               contentType: .password,
                                               keyboardType: .alphabet,
                                               textAccessibilityLabel: "Campo de texto Senha")
        
        passwordTextField.configureTextField(presset: passwordPresset)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
        let confirmPasswordPresset = DefaultTextField(text: "",
                                                      placeholder: "Confirmação de senha",
                                                      contentType: .password,
                                                      keyboardType: .alphabet,
                                                      textAccessibilityLabel: "Campo de texto Confirmação de Senha")
        
        confirmPasswordTextField.configureTextField(presset: confirmPasswordPresset)
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.delegate = self
        
    }
    
    private func clearFields() {
        
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        
    }
}

// MARK: UserViewControllerDelegate
extension UserViewController: UserViewControllerDelegate {
    
    func getInformationBack(data: String?) {
        
        if let result = data {
            
            message(title: "Usuário", message: "Cadastro realizado com sucesso")
            KeychainWrapper.standard.set("token", forKey: result)
            
        } else {
            
            message(title: "Erro!", message: "Ocorreu um erro ao realizar o cadastro", error: true)
            
        }
    }
    
}
