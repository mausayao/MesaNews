//
//  DefaultTextField.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 14/04/21.
//

import UIKit

struct DefaultTextField: MSTextFieldPressetProtocol {
    
    var borderStyle: UITextField.BorderStyle { .roundedRect }
    
    var contentType: UITextContentType
    
    var keyboardType: UIKeyboardType
    
    var placeholder: String
    
    var textAccessibilityLabel: String
    
    var text: String
    
    var textAlignment: NSTextAlignment { .left }
    
    init(text: String,
         placeholder: String,
         contentType: UITextContentType,
         keyboardType: UIKeyboardType,
         textAccessibilityLabel: String) {
        
        self.text = text
        self.placeholder = placeholder
        self.contentType = contentType
        self.keyboardType = keyboardType
        self.textAccessibilityLabel = textAccessibilityLabel
    
    }
    
}
