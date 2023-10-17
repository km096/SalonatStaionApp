//
//  LoginVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {
    
    @IBOutlet weak var enterPhoneNumLabel: UILabel!
    @IBOutlet weak var phoneNumbetTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    

    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "login", titleColor: .black, tintColor: .black, font: .light, fontSize: 30)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        enterPhoneNumLabel.initLabel(title: "Please, Enter your phone number to login:", titleColor: .black, backgroundColor: .clear, aliggment: .natural, font: .semiBold, fontSize: 20)
        
        nextButton.initButton(title: "Next", titleColor: .white, backgroundColor: UIColor.buttonColor, radius: 25, font: .regular, fontSize: 26)
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if phoneNumbetTextField.text?.count != 10 {
            SVProgressHUD.showError(withStatus: "please enter valid Phone Number (10 numbers)")
        } else {
            
        }
    }
}
