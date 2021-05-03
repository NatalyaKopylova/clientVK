//
//  ViewController.swift
//  clientVK
//
//  Created by Natalia on 05.04.2021.
//

import UIKit

class EntranceViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var indicatorUIStackView: IndicatorView!
    
    let loginTabBarSegue = "loginTabBarSegue"
       
    @IBAction func exit(_seg: UIStoryboardSegue){}

    @IBAction func exit2(_seg: UIStoryboardSegue) {}
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        IndicatorStackView
    }
    
    func alertWindowError(alertText: String){
        let alertController = UIAlertController(title: "Ошибка", message: alertText, preferredStyle: UIAlertController.Style.alert)
        let actionButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: {_ in
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        })
        alertController.addAction(actionButton)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func loginTouch(_ sender: UIButton) {
        guard let login = self.loginTextField.text,
              let password = self.passwordTextField.text,
              login.trimmingCharacters(in: .whitespacesAndNewlines) == "admin",
              password.trimmingCharacters(in: .whitespacesAndNewlines) == "123"
              else {
            alertWindowError(alertText: "Неправильный логин или пароль")
            return
             }
        performSegue(withIdentifier: self.loginTabBarSegue, sender: self)
    }
}

