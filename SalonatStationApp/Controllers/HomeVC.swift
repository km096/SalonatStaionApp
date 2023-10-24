//
//  HomeVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/20/23.
//

import UIKit
import ProgressHUD

class HomeVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var pendingRequestsView: UIView!
    @IBOutlet weak var pendingRequestsCollectionView: UICollectionView!
    @IBOutlet weak var servicesTableView: UITableView!
    @IBOutlet weak var newServiceView: UIView!
    @IBOutlet weak var addNewServiceButton: UIButton!
    @IBOutlet weak var emptyPendingRequestView: UIView!
    
    var pendingRequestsCount = 0
    var servicesCount = 0
    var skip = 0
    var pendingRequests = [SalonOrderData]()
    var servicesList = [SalonServiceData]()
    var addServiceView: AddServicesView!
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getServiceList()
        getPendingRequests()
    }
   
    //MARK: - UpdateUI
    func setupViews() {
        pendingRequestsCollectionView.delegate = self
        pendingRequestsCollectionView.dataSource = self
        pendingRequestsCollectionView.register(PendingRequestsCell.nib, forCellWithReuseIdentifier: PendingRequestsCell.identifier)
        
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        servicesTableView.register(ServicesCell.nib, forCellReuseIdentifier: ServicesCell.identifier)
        
        newServiceView.setShadow(shadowRadius: 10, opacity: 0.3)
        addNewServiceButton.initButton(title: "Add New Service", titleColor: .white, backgroundColor: Constants.Colors.pinkColor, radius: 25, font: .regular, fontSize: 16, target: self, action: #selector(goToAddServiceScreen))
    }
    
    
    
    func showAddServiceView() {
        if pendingRequestsCount == 0 && servicesCount == 0 {
            addServiceView = AddServicesView(frame: CGRectMake(0, 0, view.bounds.width, getSafeAreaHeight()))
            addServiceView.setupAddServiceView()
            addServiceView.addServiceButton.addTarget(self, action: #selector(goToAddServiceScreen), for: .touchUpInside)
            view.addSubview(addServiceView)
        } 
    }
    
    //MARK: - APICalls
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
                guard let data = result?.data else { return }
                strongSelf.servicesList = data
                strongSelf.servicesCount = data.count
                
                DispatchQueue.main.async {
                    strongSelf.showAddServiceView()
                    strongSelf.servicesTableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
                }
            }
            
        }
    }
    
    func getPendingRequests() {
        ProgressHUD.show()
        SalonAPI.shared.salonOrders(status: "completed", skip: skip) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            ProgressHUD.dismiss()
            switch result {
                
            case .success(let result):
                guard let data = result?.data else { return }
                strongSelf.pendingRequestsCount = data.count
                strongSelf.pendingRequests = data
                
                DispatchQueue.main.async {
                    if strongSelf.pendingRequestsCount == 0 {
                        strongSelf.emptyPendingRequestView.isHidden = false
                        strongSelf.pendingRequestsCollectionView.isHidden = true
                    }
                    strongSelf.emptyPendingRequestView.isHidden = true

                    strongSelf.pendingRequestsCollectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
                }
                
            }
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
