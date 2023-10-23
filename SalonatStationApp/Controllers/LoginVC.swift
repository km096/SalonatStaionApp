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
        
        if phoneNumbetTextField.text?.count != 11 {
            ProgressHUD.showError("please enter valid Phone Number (10 numbers)")
        } else {
            login()
        }
    }
    
    //MARK: - APICalls
    private func login() {
        if let phoneNumber = phoneNumbetTextField.text {
            
            let parameters = ["phone": convertToEnglish(inputStr: phoneNumber), "password": "MN123456789"]
            
            ProgressHUD.show()
            SalonAPI.shared.login(parameters: parameters) { [weak self] result in
                guard let strongSelf = self else { return }
                ProgressHUD.dismiss()
                
                switch result {
                case .success(let result):
                    guard let message = result?.message else { return }
                    ProgressHUD.showSuccess(message)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        guard let verifacationCodeVC = strongSelf.storyboard?.instantiateViewController(identifier: Constants.Identifiers.verifacationCodeVC) as? VerifacationCodeVC else {
                            return
                        }
                        verifacationCodeVC.phoneNumber = strongSelf.convertToEnglish(inputStr: phoneNumber)
                        verifacationCodeVC.token = result?.token
                        verifacationCodeVC.userId = result?.data?.id
                        
                        strongSelf.navigationController?.pushViewController(verifacationCodeVC, animated: true)
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        if error.code == 401 {
                            ProgressHUD.showError("Enter the correct phone number")
                        } else {
                            ProgressHUD.showError("\(error.localizedDescription)")
                        }
                    }
                }
            }
            
        }
        
        
    }
}
