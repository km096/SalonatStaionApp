//
//  PickerViewExt.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/25/23.
//

import UIKit

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
            return servicesList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case categoryPicker:
            return categoriesList[row].name
        default:
            return servicesList[row].name
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case categoryPicker:
            categoryCurrentIdex = row
            categoryTextField.text = categoriesList[row].name
            
        default:
            serviceCurrentIdex = row
            serviceTextField.text = servicesList[row].name

        }
    }
    
}

