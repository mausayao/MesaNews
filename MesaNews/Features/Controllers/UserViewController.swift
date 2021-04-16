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
        self.showSpinner(onView: self.view)
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
            Utils.configButton(self.saveButton)
        }
        
        saveButton.layer.cornerRadius = 20.0
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
}

// MARK: UITextFieldDelegate
extension UserViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let tag = textField.tag
        
        if nameTextField.tag == tag {
            
            if let name = nameTextField.text, !name.isEmpty {
                viewModel.name = name
            }
        }
        
        if emailTextField.tag == tag {
            
            if let email = emailTextField.text, !email.isEmpty {
                
                if Utils.isValidEmail(email) {
                    viewModel.email = email
                } else {
                    Utils.message(title: "E-mail",
                                  message: "Campo inválido",
                                  error: true,
                                  view: self,
                                  completion: nil)
                }
            }
        }
        
        if confirmPasswordTextField.tag == tag {
            
            guard let confirm = confirmPasswordTextField.text, !confirm.isEmpty else { return }
            guard let pass = passwordTextField.text, !pass.isEmpty else { return }
            
            if !isAPasswordValid(password: pass, confirm: confirm) {
                
                Utils.message(title: "Senha",
                              message: "Senha não são iguais",
                              error: true,
                              view: self,
                              completion: nil)
                
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
    
    private func isAPasswordValid(password: String, confirm: String) -> Bool {
        
        return password == confirm
        
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
        self.removeSpinner()
        if let result = data {
            
            Utils.message(title: "Usuário", message: "Cadastro realizado com sucesso", view: self) {
                KeychainWrapper.standard.set("token", forKey: result)
                self.navigationController?.popViewController(animated: true)
            }
           
        } else {
            
            Utils.message(title: "Erro!",
                          message: "Ocorreu um erro ao realizar o cadastro",
                          error: true,
                          view: self, completion: nil)
        }
    }
    
}
