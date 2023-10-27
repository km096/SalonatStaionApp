//
//  EmptyPendingRequestView.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/21/23.
//

import UIKit

class EmptyPendingRequestView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emptyPendingImageView: UIImageView!
    @IBOutlet weak var emptyPendingLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let nibName = String(describing: type(of: self))
        Bundle.main.loadNibNamed(nibName, owner: self)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth]
        addSubview(contentView)

    }
    
    func setupView() {
        emptyPendingLabel.initLabel(title: "There are no requests right now, create new services and offers to be more active.", titleColor: Constants.Colors.greyFont, backgroundColor: .clear, aliggment: .left, font: .medium, fontSize: 12)
    }
        
}
