//
//  MSTextFieldPressetProtocol.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 14/04/21.
//

import UIKit

protocol MSTextFieldPressetProtocol {
    
    var borderStyle: UITextField.BorderStyle { get }
    var contentType: UITextContentType { set get }
    var keyboardType: UIKeyboardType { set get }
    var placeholder: String { set get }
    var textAccessibilityLabel: String { set get }
    var text: String {  set get }
    var textAlignment: NSTextAlignment { get }
    
}
