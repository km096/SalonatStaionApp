//
//  AddServicesView.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/20/23.
//

import UIKit

class AddServicesView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var addServicesImageView: UIImageView!
    @IBOutlet weak var addServicesToStartLabel: UILabel!
    @IBOutlet weak var addServiceButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("AddServicesView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func setupAddServiceView() {
        addServicesToStartLabel.initLabel(title: "Please Add services to start you \n journey...", titleColor: .black, backgroundColor: .clear, aliggment: .center, font: .regular, fontSize: 20)
        
        addServiceButton.initButton(title: "Add Service", titleColor: .white, backgroundColor: UIColor.buttonColor, radius: 25, font: .regular, fontSize: 16)
    }
    
    

}
