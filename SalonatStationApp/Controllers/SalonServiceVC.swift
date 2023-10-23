//
//  SalonServiceVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/23/23.
//

import UIKit
import ProgressHUD

class SalonServiceVC: UIViewController {

    @IBOutlet weak var serviceTableView: UITableView!
    @IBOutlet weak var newServiceBackView: UIView!
    @IBOutlet weak var addNewServiceButton: UIButton!
    
    
    var salonServiceList = [SalonServiceData]()
    var servicesCount = 0
    var skip = 0
    var addServiceView: AddServicesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getServiceList()
    }
    
    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "Service", titleColor: .black, tintColor: .black, font: .regular, fontSize: 20)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        newServiceBackView.setShadow(shadowRadius: 10, opacity: 0.3)
        addNewServiceButton.initButton(title: "Add New Service", titleColor: .white, backgroundColor: Constants.Colors.pinkColor, radius: 25, font: .regular, fontSize: 16, target: self, action: #selector(goToAddServiceScreen))
        
    }
    
    func setupTableView() {
        serviceTableView.delegate = self
        serviceTableView.dataSource = self
        serviceTableView.register(ServicesCell.nib, forCellReuseIdentifier: ServicesCell.identifier)
        
    }
    
    func getServiceList() {
        let id = UserDefaults.standard.integer(forKey: Constants.salonIdKey)
        ProgressHUD.show()
        SalonAPI.shared.getSalonService(id: 13) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            ProgressHUD.dismiss()
            switch result {
                
            case .success(let result):
                let data = result?.data
                strongSelf.salonServiceList = data ?? []
//                strongSelf.servicesCount = data?.count ?? 0
                strongSelf.showAddServiceView()
                DispatchQueue.main.async {
                    strongSelf.serviceTableView.reloadData()
                }
            case .failure(let error):
                ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
            }
            
        }
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
    
    //MARK: - Navigation
    @objc func goToAddServiceScreen() {
        guard let addServiceVC = storyboard?.instantiateViewController(withIdentifier: Constants.Identifiers.addServiceVC) as? AddNewServiceVC else {
            return
        }
        self.navigationController?.pushViewController(addServiceVC, animated: true)
    }

    

}

extension SalonServiceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 //salonServiceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.identifier, for: indexPath) as? ServicesCell else {
            return UITableViewCell()
        }
        cell.setupCell(model: salonServiceList[indexPath.row])
        return cell
    }
    
    
    
}
