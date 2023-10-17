//
//  Extensions.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import UIKit

extension UINavigationController {
    
    func setNavigationBar(navigationItem: UINavigationItem, title: String, titleColor: UIColor, tintColor: UIColor, font: ChooseFont, fontSize: CGFloat) {
        navigationItem.title = title
        self.navigationBar.titleTextAttributes = [.foregroundColor: titleColor]
        self.navigationBar.tintColor = tintColor
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: CustomFont(index: font), size: fontSize) ?? UIFont()]
        self.navigationBar.titleTextAttributes = textAttributes
//        [.font: UIFont(name: CustomFont(index: font), size: fontSize) ?? UIFont()]
        self.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
//        self.navigationBar.backItem?.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UILabel {
    
    func initLabel(title: String, titleColor: UIColor, backgroundColor: UIColor, aliggment: NSTextAlignment, font: ChooseFont, fontSize: CGFloat) {
        self.textAlignment = aliggment
        self.text = title
        self.textColor = titleColor
        self.backgroundColor = backgroundColor
        self.font = UIFont(name: CustomFont(index: font), size: fontSize)
    }
}


extension UIButton {
    
    func initButton(title: String, titleColor: UIColor, backgroundColor: UIColor, radius: CGFloat, font: ChooseFont, fontSize: CGFloat, target: Any? = nil, action: Selector? = nil) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont(name: CustomFont(index: font), size: fontSize)
        self.layer.backgroundColor = backgroundColor.cgColor
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        if let action = action {
            self.addTarget(target, action: action, for: .touchUpInside)
        }
    }
}

extension UIColor {
    static var buttonColor = #colorLiteral(red: 0.9552590251, green: 0.4643781185, blue: 0.4304232001, alpha: 1)
}

enum ChooseFont: String {
    case semiBold = "Cairo-SemiBold"
    case regular = "Cairo-Regular"
    case bold = "Cairo-Bold"
    case light = "Cairo-light"
    case medium = "Cairo-Medium"
   
}

func CustomFont(index: ChooseFont) -> String {
    switch index {
    case .bold:
        return ChooseFont.bold.rawValue
        
    case .regular:
        return ChooseFont.regular.rawValue
    
    case .semiBold:
        return ChooseFont.semiBold.rawValue

    case .light:
        return ChooseFont.light.rawValue

    case .medium:
        return ChooseFont.medium.rawValue

    }
    
}
