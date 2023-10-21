//
//  HomeVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/20/23.
//

import UIKit

class HomeVC: UIViewController {

    
    let label: UILabel = {
        let label = UILabel()
        label.initLabel(title: "Home", titleColor: .black, backgroundColor: .clear, aliggment: .center, font: .light, fontSize: 20)
        return label
    }()
    
    var peendingRequestsCount = 0
    var requestsCount = 0
    
    var addServiceView: AddServicesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAddServiceView()
        setupAddServiceView()
        
    }
   
    func setupViews() {

    }
    
    func handleNavBar() {
        navigationItem.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.979714334, green: 0.8133532405, blue: 0.8037056327, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "defaultImage"), for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: ChooseFont.regular.rawValue, size:20) ?? UIFont()]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupAddServiceView() {
        addServiceView.addServicesToStartLabel.initLabel(title: "Please Add services to start you \n journey...", titleColor: .black, backgroundColor: .clear, aliggment: .center, font: .regular, fontSize: 20)
        
            addServiceView.addServiceButton.initButton(title: "Add Service", titleColor: .white, backgroundColor: UIColor.buttonColor, radius: 25, font: .regular, fontSize: 16,target: self, action: #selector(goToAddServiceScreen))
    }
    
    @objc func goToAddServiceScreen() {
        print("Add service screen")
    }
    
    func showAddServiceView() {
        if peendingRequestsCount == 0 && requestsCount == 0 {
            addServiceView = AddServicesView(frame: CGRectMake(0, 0, view.bounds.width, getSafeAreaHeight()))
            
            view.addSubview(addServiceView)
        }
    }

    func getSafeAreaHeight() -> CGFloat {
      let viewHeight = view.bounds.height
      let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0.0
      let tabBarHeight = tabBarController?.tabBar.bounds.height ?? 0.0

      return viewHeight - navigationBarHeight - tabBarHeight
    }

    

}
