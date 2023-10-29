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
    var servicesList = [GetServicesDataModel]()
    var services = Array(repeating: ServiceModel(), count: 4)
    var serviceDic = [[String: Any?]]()
    
    let id = UserDefaults.standard.integer(forKey: Constants.salonIdKey)
    var serviceId: Int?
    let arrServiceTitles = ["Home Details", "Vip Details", "Normal Details", "Professional Details"]
    let categoryPicker = UIPickerView()
    let servicePicker = UIPickerView()
    
    let fromDatePicker = UIDatePicker()
    let toDatePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    var categoryCurrentIdex = 0
    var serviceCurrentIdex = 0
    
    let typeId = [4,3,1,2]
    var addServiceCheckedArray = [0, 0, 0, 0]
    var addOfferCheckedArray = [0, 0, 0, 0]
    var additionsCheckedArray = [0, 0, 0, 0]
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupViews()
        setDateAndTime()
        initializeHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCategories()
        if let tabBar = tabBarController as? TabBarController {
            tabBar.tabBar.isHidden = true
        } 
    }
    
    //MARK: - Setup
    func setupViews() {
        self.navigationController?.setNavigationBar(navigationItem: navigationItem, title: "Add Service", titleColor: .black, tintColor: .black, font: .light, fontSize: 30)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        saveButton.initButton(title: "Save", titleColor: .white, backgroundColor: Constants.Colors.pinkColor, radius: 25, font: .regular, fontSize: 16, target: self, action: #selector(validation))
        
        categoryTextField.inputAccessoryView = setCategoryToolBar()
        serviceTextField.inputAccessoryView = setServiceToolBar()
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
    
    func setCategoryToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneCategoryAction))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
    
    func setServiceToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneServiceAction))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
        
    @objc func doneCategoryAction() {
        if categoriesList.count != 0 {
            categoryTextField.text = categoriesList[categoryCurrentIdex].name
            getService(categoryId: categoriesList[categoryCurrentIdex].id ?? 0)
        }
        view.endEditing(true)
    }
    
    @objc func doneServiceAction() {
        if servicesList.count != 0 {
            serviceTextField.text = servicesList[serviceCurrentIdex].name
            serviceId = servicesList[serviceCurrentIdex].id ?? 0
        }
        view.endEditing(true)
    }
    
    //MARK: - Validation
    @objc func validation() {
        serviceDic.removeAll()
        guard let categoryText = categoryTextField.text,
                let serviceText = serviceTextField.text else { return }
        
        if categoryText.isEmpty {
            ProgressHUD.showError("Please choose category")
            return
        }
        
        if serviceText.isEmpty {
            ProgressHUD.showError("Please choose service")
            return
        }
        
        if addServiceCheckedArray == [0,0,0,0] {
            ProgressHUD.showError("Please at least add one service details")
            return
        }
        
        for index in 0 ..< addServiceCheckedArray.count {
            if addServiceCheckedArray[index] == 0 {
                continue
            }
            
            if services[index].price.isNilOrEmpty() {
                ProgressHUD.showError("Please enter main price")
                return
            }
            
            if services[index].numOfPersons.isNilOrEmpty() {
                ProgressHUD.showError("Please enter no of persons")
                return
            }
            
            if addOfferCheckedArray[index] == 0 {
                appendToServiceDic(index: index)
                continue
            }
            
            if services[index].offerPrice.isNilOrEmpty() {
                ProgressHUD.showError("Please enter offer price")
                return
            }
            
            if Int(services[index].offerPrice ?? "0") ?? 0 > Int(services[index].price ?? "0") ?? 0 {
                ProgressHUD.showError("Please enter offer price less than main price")
                return
            }
            
            if services[index].fromDate.isNilOrEmpty() {
                ProgressHUD.showError("Please enter offer from date")
                return
            }
            
            if services[index].toDate.isNilOrEmpty() {
                ProgressHUD.showError("Please enter offer to date")
                return
            }
                        
            appendToServiceDic(index: index)
        }
        addService(dic: setAddServiceDic())
    }
    
        //MARK: - Helpers
    func setDateAndTime() {
        let today = Date()
        fromDatePicker.datePickerMode = .dateAndTime
        toDatePicker.datePickerMode = .dateAndTime
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = Constants.dateFormat

        fromDatePicker.minimumDate = today
        fromDatePicker.maximumDate = Calendar.current.date(bySetting: .day, value: 0, of: toDatePicker.minimumDate ?? Date())
        toDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: fromDatePicker.maximumDate ?? Date())
        
        if #available(iOS 13.4, *) {
            fromDatePicker.preferredDatePickerStyle = .wheels
            toDatePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    private func appendToServiceDic(index: Int) {
        if addOfferCheckedArray[index] == 0 {
            serviceDic.append(["type_id":typeId[index],
                               "price":convertToEnglish(inputStr: services[index].price ?? ""),
                               "addition":additionsCheckedArray[index],
                               "no_person":convertToEnglish(inputStr: services[index].numOfPersons ?? "")])
        } else {
            serviceDic.append(["type_id":typeId[index],
                               "price":convertToEnglish(inputStr: services[index].price ?? ""),
                               "addition":additionsCheckedArray[index],
                               "no_person":convertToEnglish(inputStr: services[index].numOfPersons ?? ""),
                               "offer_price": convertToEnglish(inputStr: services[index].offerPrice ?? ""),
                               "from": services[index].fromDate ?? "",
                               "to": services[index].toDate ?? ""])
        }
        
    }
    
    private func setAddServiceDic() -> [String: Any]{
        var dic = [String: Any]()
        dic.updateValue(id, forKey: "center_id")
        dic.updateValue(serviceId ?? 0, forKey: "service_id")
        dic.updateValue(serviceDic, forKey: "services")
        return dic
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
                
            case .failure(let error):
                ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
            }
        }
    }
    
    func getService(categoryId: Int) {
        ProgressHUD.show()
        SalonAPI.shared.getServices(categoryId: categoryId) { [weak self] result in
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
                    strongSelf.serviceTableView.reloadData()
                }
            case .failure(let error):
                ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
            }
        }
    }
    
    func addService(dic: [String: Any]) {
        ProgressHUD.show()
        SalonAPI.shared.salonAddService(dic: dic) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            ProgressHUD.dismiss()
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    strongSelf.navigationController?.popViewController(animated: true)
                }
                
            case .failure(let error):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    ProgressHUD.showError("\(error.userInfo[NSLocalizedDescriptionKey] ?? "")")
                }
                
            }
        }
    }
}


    //MARK: - TextFieldsDelegates
extension AddNewServiceVC: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        var filedTag = textField.tag % 100
        let cellIndex = textField.tag / 100

            if filedTag == 1 {
                services[cellIndex].price = textField.text ?? ""
            } else if filedTag == 2 {
                services[cellIndex].numOfPersons = textField.text ?? ""
            } else if filedTag == 3 {
                services[cellIndex].offerPrice = textField.text ?? ""
            } else if filedTag == 4 {
                let date = dateFormatter.string(from: fromDatePicker.date)
                textField.text = convertDateFormat(inputDateString: date)
                services[cellIndex].fromDate = textField.text ?? ""
            } else if filedTag == 5 {
                let date = dateFormatter.string(from: toDatePicker.date)
                textField.text = convertDateFormat(inputDateString: date)
                services[cellIndex].toDate = textField.text ?? ""
            }
        return true

    }

}

