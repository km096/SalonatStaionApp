//
//  TableViewExt.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/21/23.
//

import UIKit

//MARK: - Services
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.identifier, for: indexPath) as? ServicesCell else {
            return UITableViewCell()
        }
        cell.setupCell(model: servicesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // Your cell height
    }
    
}
