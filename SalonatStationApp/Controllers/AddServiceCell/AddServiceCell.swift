//
//  AddServiceCell.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/24/23.
//

import UIKit

class AddServiceCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    //MARK: - IBOutlets
    //Buttons
    @IBOutlet weak var addServiceButton: UIButton!
    @IBOutlet weak var addOfferButton: UIButton!
    @IBOutlet weak var deleteOfferButton: UIButton!
    @IBOutlet weak var additionsButton: UIButton!
    
    //Labels
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var addOfferLabel: UILabel!
    @IBOutlet weak var additionsLabel: UILabel!
    
    //TextFileds
    @IBOutlet weak var servicePriceTextField: UITextField!
    @IBOutlet weak var numberOfPersonsTextField: UITextField!
    @IBOutlet weak var offerPriccTextField: UITextField!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var offerSection: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViews() {
        addOfferLabel.initLabel(title: "Add Offer", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .regular, fontSize: 14)
        additionsLabel.initLabel(title: "Additios", titleColor: .black, backgroundColor: .clear, aliggment: .left, font: .regular, fontSize: 14)
        
        backView.setBorderWithSahdow(cornerRadius: 5, borderWidth: 1, borderColor: Constants.Colors.pinkColor.cgColor)
        let addService = #imageLiteral(resourceName: "Rectangle 123")
        addServiceButton.setImage(UIImage(named: "unchecked"), for: .normal)
        addOfferButton.setImage(UIImage(named: "Rectangle 123"), for: .normal)
        additionsButton.setImage(UIImage(named: "Rectangle 123"), for: .normal)
        
        
    }
    
}
