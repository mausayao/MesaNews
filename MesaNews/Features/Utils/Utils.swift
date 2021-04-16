//
//  Utils.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 15/04/21.
//

import UIKit

final class Utils {
    
    static func message(title: String, message: String, error: Bool = false, view: UIViewController, completion:  (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { action in
            if (!error) {
                completion?()
            }
        }
        alert.addAction(action)
        view.present(alert, animated: true, completion: nil)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try? NSRegularExpression(pattern: TextFieldConstants.Regex.email)
        return regex?.firstMatch(in: email, options: [], range: range) != nil
        
    }
    
    static func configButton(_ button: UIButton) {
        
        if button.isEnabled {
            
            button.titleLabel?.textColor = .white
            button.backgroundColor = .black
            
        } else {
            
            button.titleLabel?.textColor = .lightGray
            button.backgroundColor = .systemGray5
        }
    }
    
}
