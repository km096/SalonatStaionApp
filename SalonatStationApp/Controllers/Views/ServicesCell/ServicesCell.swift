//
//  YourServicesCell.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/21/23.
//

import UIKit

class ServicesCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }


    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var servaiceNameLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.contentView.frame = self.contentView.frame.inset(by: padding)
    }
    
    func setupCell(model: SalonServiceData) {
        servaiceNameLabel.initLabel(title: "\(model.name ?? "Layers")", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .semiBold, fontSize: 18)
        
        categoryNameLabel.initLabel(title: "(\(model.categoryName ?? "Hair Cut"))", titleColor: Constants.Colors.pinkColor, backgroundColor: .clear, aliggment: .left, font: .semiBold, fontSize: 15)
        
//        backView.setBorderWithSahdow(cornerRadius: 5, borderWidth: 1, borderColor: Constants.Colors.pinkColor.cgColor)
        backView.setShadow(shadowRadius: 20, opacity: 1)
    }
    
}
