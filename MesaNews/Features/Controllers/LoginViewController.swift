//
//  ViewController.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 13/04/21.
//

import UIKit

final class LoginViewController: UIViewController {

  
    @IBAction func accessUserView(_ sender: UIButton) {
        performSegue(withIdentifier: "CreateUserSegue", sender: nil)
    }
    
}

// MARK: Life cycle
extension LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

