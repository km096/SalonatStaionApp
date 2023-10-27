//
//  PendingRequestsCell.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/21/23.
//

import UIKit

class PendingRequestsCell: UICollectionViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    
    @IBOutlet weak var backview: UIView!
    
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var serviceDateLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var phoneNumbaerLabel: UILabel!
    @IBOutlet weak var numOfCustomersLabel: UILabel!
    
    @IBOutlet weak var acceptView: UIView!
    @IBOutlet weak var rejectView: UIView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCell(model: SalonOrderData) {
        orderIdLabel.initLabel(title: "#\(model.id ?? 0)", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .regular, fontSize: 16)
        serviceDateLabel.initLabel(title: "\(model.date ?? "" )", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .regular, fontSize: 16)
        customerNameLabel.initLabel(title: "\(model.userName ?? "name")", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .regular, fontSize: 16)
        phoneNumbaerLabel.initLabel(title: "\(model.userPhone ?? "number")", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .regular, fontSize: 16)
        numOfCustomersLabel.initLabel(title: "\(model.personNumber ?? 0)", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .regular, fontSize: 16)
        backview.setBorderWithSahdow(cornerRadius: 5, borderWidth: 1, borderColor: Constants.Colors.pinkColor.cgColor)
        backview.setShadow(shadowRadius: 5, opacity: 0.5)
        
        acceptView.setBorderWithSahdow(cornerRadius: 5, borderWidth: 1, borderColor: Constants.Colors.pinkColor.cgColor)
        acceptView.setShadow(shadowRadius: 5, opacity: 0.5)
        
        rejectView.setBorderWithSahdow(cornerRadius: 5, borderWidth: 1, borderColor: Constants.Colors.pinkColor.cgColor)
        rejectView.setShadow(shadowRadius: 5, opacity: 0.5)
    
    }
    
    

}
