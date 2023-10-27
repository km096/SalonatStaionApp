//
//  ViewController.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/15/23.
//

import UIKit

class SalonOrCustomerVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var continueAsLabel: UILabel!
    //Salon
    @IBOutlet weak var salonImageView: UIImageView!
    @IBOutlet weak var salonLabel: UILabel!
    @IBOutlet weak var salonButton: UIButton!
    //Customer
    @IBOutlet weak var customerImageView: UIImageView!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var customerButton: UIButton!
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    var salonIsChosen: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    
    func setupViews() {
//        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        continueAsLabel.initLabel(title: "Continue as:", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .semiBold, fontSize: 25)
        
        salonLabel.initLabel(title: "Salon", titleColor: .black, backgroundColor: .clear, aliggment: .center, font: .regular, fontSize: 23)
        
        customerLabel.initLabel(title: "Customer", titleColor: .black, backgroundColor: .clear, aliggment: .center, font: .regular, fontSize: 23)
        
        salonImageView.image = UIImage(named: "salon-chosen")
        customerImageView.image = UIImage(named: "customer")
        
        salonButton.addTarget(self, action: #selector(goToSalon), for: .touchUpInside)
        customerButton.addTarget(self, action: #selector(goToCustomer), for: .touchUpInside)
        
        getStartedButton.initButton(title: "Get Started", titleColor: .white, backgroundColor: Constants.Colors.pinkColor, radius: 25, font: .regular, fontSize: 16)
    }
    
    @objc func goToSalon(){
        customerImageView.image = UIImage(named: "customer")
        salonImageView.image = UIImage(named: "salon-chosen")
        salonIsChosen = true
    }
    
    @objc func goToCustomer(){
        customerImageView.image = UIImage(named: "customer-chosen")
        salonImageView.image = UIImage(named: "salon")
        salonIsChosen = false
    }


    @IBAction func getStartedButtonPressed(_ sender: Any) {
        goToLogin()
    }
    
    func goToLogin() {
        if salonIsChosen {
            guard let loginVC = storyboard?.instantiateViewController(withIdentifier: Constants.Identifiers.loginVC) as? LoginVC else {
                return
            }
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}

enum SalonOrCustomer: String {
    case Salon  = "isSalon"
    case Customer = "isCustomer"
}
