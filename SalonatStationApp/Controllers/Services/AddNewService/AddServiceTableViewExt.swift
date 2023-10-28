//
//  TableViewExt.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/25/23.
//

import UIKit

//MARK: - TableViewDelegates
extension AddNewServiceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServiceTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddServiceCell.identifier, for: indexPath) as? AddServiceCell else {
            return UITableViewCell()
        }
        
        cell.serviceNameLabel.text = arrServiceTitles[indexPath.row]
        cell.additionsSection.isHidden = indexPath.row == 0
        
        if services.count != 0 {
            cell.servicePriceTextField.text = services[indexPath.row].price ?? ""
            cell.numberOfPersonsTextField.text = services[indexPath.row].numOfPersons ?? ""
            cell.offerPriccTextField.text = services[indexPath.row].offerPrice ?? ""
            cell.fromDateTextField.text = convertTimeFrom24To12(time24: services[indexPath.row].fromDate ?? "")
            cell.toDateTextField.text = convertTimeFrom24To12(time24: services[indexPath.row].toDate ?? "")
        }
        
        cell.servicePriceTextField.delegate = self
        cell.numberOfPersonsTextField.delegate = self
        cell.offerPriccTextField.delegate = self
        cell.fromDateTextField.delegate = self
        cell.toDateTextField.delegate = self
        cell.fromDateTextField.inputView = fromDatePicker
        cell.toDateTextField.inputView = toDatePicker
        //Cell burrons tags
        cell.addServiceButton.tag = indexPath.row + 10 
        cell.addOfferButton.tag = indexPath.row + 20
        cell.additionsButton.tag = indexPath.row + 30
        
        //Cell TextFieds tags
        cell.servicePriceTextField.tag = indexPath.row * 100 + 1
        cell.numberOfPersonsTextField.tag = indexPath.row * 100 + 2
        cell.offerPriccTextField.tag = indexPath.row * 100 + 3
        cell.fromDateTextField.tag = indexPath.row * 100 + 4
        cell.toDateTextField.tag = indexPath.row * 100 + 5
        
        cell.addServiceButton.setImage(UIImage(named: addServiceCheckedArray[indexPath.row] == 0 ? "unchecked" : "checked"), for: .normal)
        cell.addOfferButton.setImage(UIImage(named: addOfferCheckedArray[indexPath.row] == 0 ? "Rectangle 123" : "Group 49440"), for: .normal)
        cell.additionsButton.setImage(UIImage(named: additionsCheckedArray[indexPath.row] == 0 ? "Rectangle 123" : "Group 49440"), for: .normal)

        cell.offerSection.isHidden = addOfferCheckedArray[indexPath.row] == 0
        

        cell.addServiceButton.addTarget(self, action: #selector(addServiceButtonTapped), for: .touchUpInside)
        cell.addOfferButton.addTarget(self, action: #selector(addOfferButtonTapped), for: .touchUpInside)
        cell.additionsButton.addTarget(self, action: #selector(additionsButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
   @objc func addServiceButtonTapped(button: UIButton){
        for index in 0 ..< 4{//10, 11, 12, 13
            if button.tag == index + 10 {
                addServiceCheckedArray[index]  == 0 ? (addServiceCheckedArray[index] = 1) : (addServiceCheckedArray[index] = 0)
                
            }

        }

        serviceTableView.reloadData()
        
    }
    
    @objc func addOfferButtonTapped(button: UIButton){
        for index in 0 ..< 4 {
            if button.tag == index + 20 {
                addOfferCheckedArray[index] == 0 ? (addOfferCheckedArray[index] = 1):(addOfferCheckedArray[index] = 0)
            }

        }

        serviceTableView.reloadData()
    }
    
    @objc func additionsButtonTapped(button:UIButton){
        for index in 0 ..< 4{
            if button.tag == index + 30 {
                additionsCheckedArray[index] == 0 ? (additionsCheckedArray[index] = 1):(additionsCheckedArray[index] = 0)
            }
        }

        serviceTableView.reloadData()
        
    }
    
    
}
