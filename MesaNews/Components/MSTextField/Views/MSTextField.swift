//
//  MSTextField.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 14/04/21.
//

import UIKit

final class MSTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: Helpers
extension MSTextField {
    
    func configureTextField(presset: MSTextFieldPressetProtocol) {
        
        placeholder = presset.placeholder
        textAlignment = presset.textAlignment
        borderStyle = presset.borderStyle
        text = presset.text
        accessibilityLabel = presset.textAccessibilityLabel
        keyboardType = presset.keyboardType
        textContentType = presset.contentType
        
        backgroundColor = .white
        
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .black
        autocapitalizationType = .words
        autocorrectionType = .yes
        spellCheckingType = .yes
     
    }
}

