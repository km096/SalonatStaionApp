//
//  SalonServiceVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/23/23.
//

import UIKit
import ProgressHUD

class SalonServiceVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var serviceTableView: UITableView!
    @IBOutlet weak var newServiceBackView: UIView!
    @IBOutlet weak var addNewServiceButton: UIButton!
    
        //MARK: - Properties
    var skip = 0
    var servicesCount = 0
    var salonServiceList = [SalonServiceData]()
    var addServiceView: AddServicesView!
    let id = UserDefaults.standard.integer(forKey: Constants.salonIdKey)
    
        //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        skip = 0
        servicesCount = 0
        getServiceList()
        if let tabBar = tabBarController as? TabBarController {
            tabBar.tabBar.isHidden = false
        }
        
    }
    
    //MARK: - Setup
    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "Service", titleColor: .black, tintColor: .black, font: .regular, fontSize: 20)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        newServiceBackView.setShadow(shadowRadius: 5, opacity: 0.3)
        addNewServiceButton.initButton(title: "Add New Service", titleColor: .white, backgroundColor: Constants.Colors.pinkColor, radius: 25, font: .regular, fontSize: 16, target: self, action: #selector(goToAddServiceScreen))
        
    }
    
    
    func setupTableView() {
        serviceTableView.delegate = self
        serviceTableView.dataSource = self
        serviceTableView.register(ServicesCell.nib, forCellReuseIdentifier: ServicesCell.identifier)
        
    }
    
    func showAddServiceView() {
        if servicesCount == 0 {
            addServiceView = AddServicesView(frame: CGRectMake(0, 0, view.bounds.width, getSafeAreaHeight()))
            addServiceView.setupAddServiceView()
            addServiceView.addServiceButton.addTarget(self, action: #selector(goToAddServiceScreen), for: .touchUpInside)
            newServiceBackView.isHidden = true
            view.addSubview(addServiceView)
        }
    }
    
    //MARK: - ApiCalls
    func getServiceList() {
        ProgressHUD.show()
        SalonAPI.shared.salonService(id: id, skip: skip) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            ProgressHUD.dismiss()
            switch result {
            case .success(let result):
                guard let data = result?.data else { return }
                strongSelf.salonServiceList = data
                strongSelf.servicesCount = data.count
                strongSelf.showAddServiceView()
                DispatchQueue.main.async {
                    strongSelf.serviceTableView.reloadData()
                }
            case .failure(let error):
                ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
            }
            
        }
    }
    
    func getMoreService() {
        ProgressHUD.show()
        SalonAPI.shared.salonService(id: id, skip: skip) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            ProgressHUD.dismiss()
            switch result {
            case .success(let result):
                guard let data = result?.data else { return }
                strongSelf.servicesCount = data.count
                if strongSelf.servicesCount != 0 {
                    strongSelf.salonServiceList.append(contentsOf: data)
                    strongSelf.skip = strongSelf.salonServiceList.count
                    DispatchQueue.main.async {
                        strongSelf.serviceTableView.reloadData()
                    }
                }
            case .failure(let error):
                ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
            }
            
        }
    }
    
    //MARK: - Navigation
    @objc func goToAddServiceScreen() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let addServiceVC = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.addServiceVC) as? AddNewServiceVC else {
            return
        }
        self.navigationController?.pushViewController(addServiceVC, animated: true)
    }

    

}

    //MARK: - TableViewDelegate
extension SalonServiceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salonServiceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.identifier, for: indexPath) as? ServicesCell else {
            return UITableViewCell()
        }
        cell.setupCell(model: salonServiceList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if servicesCount != 0 {
            indexPath.row == salonServiceList.count - 1 ? self.getMoreService() : nil
        }
    }
    
    
    
}
