//
//  LoginVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import UIKit
import ProgressHUD

class LoginVC: UIViewController {
    
    //MARK: - IBOtlets
    @IBOutlet weak var enterPhoneNumLabel: UILabel!
    @IBOutlet weak var phoneNumbetTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    //MARK: - UpdateUI
    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "login", titleColor: .black, tintColor: .black, font: .light, fontSize: 30)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        enterPhoneNumLabel.initLabel(title: "Please, Enter your phone number to login:", titleColor: .black, backgroundColor: .clear, aliggment: .natural, font: .semiBold, fontSize: 20)
        
        nextButton.initButton(title: "Next", titleColor: .white, backgroundColor: UIColor.buttonColor, radius: 25, font: .regular, fontSize: 26)
    }
    
    //MARK: - IBActions
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if phoneNumbetTextField.text?.count != 10 {
            ProgressHUD.showError("please enter valid Phone Number (10 numbers)")
        } else {
            goToVerifacationScreen()
        }
    }
    
    //MARK: - Navigation
    private func goToVerifacationScreen() {
        if let phoneNumber = phoneNumbetTextField.text, !phoneNumber.isEmpty {
            guard let verifacationCodeVC = storyboard?.instantiateViewController(identifier: Constants.Identifiers.verifacationCodeVC) as? VerifacationCodeVC else {
                return
            }
            verifacationCodeVC.phoneNumber = phoneNumber
            navigationController?.pushViewController(verifacationCodeVC, animated: true)
        }
        
    }
    
  
}
