//
//  VerifacationCodeVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import UIKit
import ProgressHUD
import SwiftyCodeView

class VerifacationCodeVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var enterVerificationCodeLabel: UILabel!
    @IBOutlet weak var verifacationCodeView: SwiftyCodeView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var phoneNumber: String?
    var token: String?
    var userId: Int?
    private var countdownTimer: Timer!
    private var totalTime = 60
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        resendCode()
        verifacationCodeView.delegate = self
    }
    
    //MARK: - UpdateUI
    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "Verification Code", titleColor: .black, tintColor: .black, font: .regular, fontSize: 20)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        timerLabel.text = ""
        timerLabel.isHidden = true

        
        enterVerificationCodeLabel.initLabel(title: "Please Enter Your Verification Code:", titleColor: .black, backgroundColor: .clear, aliggment: .natural, font: .semiBold, fontSize: 20)
        
        resendButton.initButton(title: "Resend?", titleColor: .black, backgroundColor: .clear, radius: 0, font: .regular, fontSize: 15)
        
        resendButton.addUnderline(title: "Resend?")
        
        nextButton.initButton(title: "Next", titleColor: .white, backgroundColor: Constants.Colors.pinkColor, radius: 25, font: .regular, fontSize: 26)
        nextButton.isEnabled = false
        runTimer()
        
        
    }
    
    func checkCode() -> Bool {
        return verifacationCodeView.code.count == 6
        
    }
    
    //MARK: - IBActions
    @IBAction func resendButtonPressed(_ sender: Any) {
        resendCode()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        verifyUser(code: verifacationCodeView.code)
    }
    
    
    //MARK: - APICalls
    func verifyUser(code: String) {
        //0106778411
        self.endTimer()
        if let phoneNumber = phoneNumber {
            let parameters = ["phone": phoneNumber, "code": self.convertToEnglish(inputStr: code)]
            ProgressHUD.show()
            
            SalonAPI.shared.verifyUser(parameters: parameters) { [weak self] result in
                guard let strongSelf = self else { return }
                
                ProgressHUD.dismiss()
                switch result {
                    
                case .success(let result):
                    guard let data = result?.data else {
                        return
                    }
                    strongSelf.endTimer()
                    UserDefaults.standard.setValue(result?.token, forKey: Constants.AccessTokenKey)
                    UserDefaults.standard.setValue(data.id, forKey: Constants.salonIdKey)
                    UserDefaults.standard.setValue(data.nameAr, forKey: Constants.salonNameArKey)
                    UserDefaults.standard.setValue(data.nameEn, forKey: Constants.salonNameEnKey)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                        guard let homeView = strongSelf.storyboard?.instantiateViewController(identifier: Constants.Identifiers.tabBarController) as? TabBarController else {
                            return
                        }

                        strongSelf.navigationController?.pushViewController(homeView, animated: true)
                    }
                    
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? ErrorMessage.genericError)")
                    }
                }
            }
        }

    }
    
    func resendCode() {
        ProgressHUD.show()
        
        SalonAPI.shared.resendCode(phone: "0106778411") { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            ProgressHUD.dismiss()
            switch result {
            case .success(let result):
                guard let message = result?.message else {return}
                DispatchQueue.main.async {
                    strongSelf.verifacationCodeView.code = ""
                    ProgressHUD.showSuccess(message)
                    strongSelf.runTimer()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? ErrorMessage.genericError)")
                }
            }
        }

    }
    
    
    
    
}

//MARK: - SWiftyCodeDelegate
extension VerifacationCodeVC: SwiftyCodeViewDelegate {
    func codeView(sender: SwiftyCodeView, didFinishInput code: String) -> Bool {
        
        nextButton.isEnabled = checkCode()
        return checkCode()
    }
    
    
}


extension VerifacationCodeVC {
    
    @objc func updateTimer() {
        self.totalTime -= 1
        
        let minutes: Int = self.totalTime / 60
        let seconds: Int = self.totalTime % 60
        
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        timerLabel.text = "\(minutesString):\(secondsString) "
        
        if self.totalTime <= 0
        {
            self.endTimer()
            
        }
    }
    
    func runTimer() {
        self.totalTime = 60
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.timerLabel.isHidden = false
            self.resendButton.isHidden = true
            
        }
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.timerLabel.isHidden = true
            self.resendButton.isHidden = false
        }
    }
    
}
