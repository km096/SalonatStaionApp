//
//  Extensions.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import UIKit

extension UIViewController {
    func convertToEnglish(inputStr: String)-> String {
        let numbersDictionary : Dictionary = [
            "٠": "0",
            "١": "1",
            "٢": "2",
            "٣": "3",
            "٤": "4",
            "٥": "5",
            "٦": "6",
            "٧": "7",
            "٨": "8",
            "٩": "9"
        ]
        var str : String = inputStr
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
}

extension UINavigationController {
    
    func setNavigationBar(navigationItem: UINavigationItem, title: String, titleColor: UIColor, tintColor: UIColor, font: ChooseFont, fontSize: CGFloat) {
        
        navigationItem.title = title
        self.navigationBar.titleTextAttributes = [.foregroundColor: titleColor]
        self.navigationBar.tintColor = tintColor
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: CustomFont(index: font), size: fontSize) ?? UIFont()]
        self.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
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
    
    func addUnderline(title: String) {
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: attributedString.length))
        
        self.setAttributedTitle(attributedString, for: .normal)

    }
}

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
            color.setFill()

            let context = UIGraphicsGetCurrentContext()
            context?.translateBy(x: 0, y: self.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            context?.setBlendMode(CGBlendMode.normal)

            let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
            context?.clip(to: rect, mask: self.cgImage!)
            context?.fill(rect)

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage!
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
