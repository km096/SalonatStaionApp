//
//  AddNewServiceVC.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/23/23.
//

import UIKit
import ProgressHUD

class AddNewServiceVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var serviceTableView: UITableView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - Property
    var categoriesCount = 0
    var servicesCount = 0
    var categoriesList = [GetCategoriesModelData]()
    var serviceList = [SalonServiceData]()
    
    let id = UserDefaults.standard.integer(forKey: Constants.salonIdKey)
    var serviceId: Int?
    
    let categoryPicker = UIPickerView()
    let servicePicker = UIPickerView()
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBar = tabBarController as? TabBarController {
            tabBar.tabBar.isHidden = true
        }
    }
    
    //MARK: - Setup
    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "Add Service", titleColor: .black, tintColor: .black, font: .light, fontSize: 30)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        saveButton.initButton(title: "Save", titleColor: .white, backgroundColor: Constants.Colors.pinkColor, radius: 25, font: .regular, fontSize: 16)
        
        
    }
    
    //MARK: - ConfigureViews
    func configureViews() {
        serviceTableView.delegate = self
        serviceTableView.dataSource = self
        serviceTableView.register(AddServiceCell.nib, forCellReuseIdentifier: AddServiceCell.identifier)
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        servicePicker.delegate = self
        servicePicker.dataSource = self
        
        categoryTextField.delegate = self
        serviceTextField.delegate = self
        
        categoryTextField.inputView = categoryPicker
        serviceTextField.inputView = servicePicker
    }
    
     
    //MARK: - APICalls
    func getCategories() {
        ProgressHUD.show()
        SalonAPI.shared.getCategories { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            ProgressHUD.dismiss()
            
            switch result {
            case .success(let result):
                guard let data = result?.data else { return }
                strongSelf.categoriesCount = data.count
                strongSelf.categoriesList = data
                
                DispatchQueue.main.async {
                    //
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
                }
                
            }
        }
    }
    
    func getService(id: Int) {
        ProgressHUD.show()
        SalonAPI.shared.getSalonService(id: id) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            ProgressHUD.dismiss()
            
            switch result {
            case .success(let result):
                guard let data = result?.data else { return }
                strongSelf.serviceList = data
                strongSelf.servicesCount = data.count
                
                DispatchQueue.main.async {
                    <#code#>
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
                }
            }
        }
    }
    
    
}

//MARK: - TableViewDelegates
extension AddNewServiceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

//MARK: - PickerViewDelegates
extension AddNewServiceVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case categoryPicker:
            return categoriesList.count
        default:
            return serviceList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case categoryPicker:
            return categoriesList[row].name
        default:
            return serviceList[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case categoryPicker:
            categoryTextField.text = categoriesList[row].name
            getService(id: categoriesList[row].id ?? 0)
            
        default:
            serviceTextField.text = serviceList[row].name
            if serviceList.count != 0 {
                serviceId = serviceList[row].id ?? 0
            }
        }
    }
    
}

extension AddNewServiceVC: UITextFieldDelegate {
    
}
