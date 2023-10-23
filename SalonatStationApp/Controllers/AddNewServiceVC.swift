//
//  AddNewServiceVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/23/23.
//

import UIKit

class AddNewServiceVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBar = tabBarController as? TabBarController {
            tabBar.tabBar.isHidden = true
        }
    }
    

    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "Add Service", titleColor: .black, tintColor: .black, font: .light, fontSize: 30)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        
    }
    
}
