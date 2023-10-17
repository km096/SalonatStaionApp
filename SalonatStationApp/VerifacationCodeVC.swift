//
//  VerifacationCodeVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import UIKit
import SwiftyCodeView

class VerifacationCodeVC: UIViewController {
    
    @IBOutlet weak var enterVerificationCodeLabel: UILabel!
    @IBOutlet weak var verifacationCodeView: SwiftyCodeView!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var phoneNumber: String?
    var token: String?
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "Verification Code", titleColor: .black, tintColor: .black, font: .regular, fontSize: 20)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        enterVerificationCodeLabel.initLabel(title: "Please Enter Your Verification Code:", titleColor: .black, backgroundColor: .clear, aliggment: .natural, font: .semiBold, fontSize: 20)
        
        resendButton.initButton(title: "Resend?", titleColor: .black, backgroundColor: .clear, radius: 0, font: .regular, fontSize: 15)
        
        resendButton.addUnderline(title: "Resend?")
        
        nextButton.initButton(title: "Next", titleColor: .white, backgroundColor: UIColor.buttonColor, radius: 25, font: .regular, fontSize: 26)
    }

}
