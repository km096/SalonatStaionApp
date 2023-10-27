//
//  Extensions.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import UIKit

//MARK: - UIViewController
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
    
    func getSafeAreaHeight() -> CGFloat {
      let viewHeight = view.bounds.height
      let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0.0
      let tabBarHeight = tabBarController?.tabBar.bounds.height ?? 0.0

      return viewHeight - navigationBarHeight - tabBarHeight
    }
    
    func initializeHideKeyboard() { 
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func convertTimeFrom12To24(time12: String) -> String {
        if time12 == "" {
            return ""
        }
        let timeComponents = time12.components(separatedBy: " ")
        guard timeComponents.count == 2,
              let hour = Int(timeComponents[0]),
              let minutes = Int(timeComponents[1].components(separatedBy: ":")[0]) else {
            return "ivalid time format"
        }
        
        var time24 = ""
        
        if timeComponents[1].contains("AM") || timeComponents[1].contains("am") {
            if hour == 12 {
                time24 = "00:\(minutes)"
            } else {
                time24 = "\(hour):\(minutes)"
            }
            
        } else if timeComponents[1].contains("PM") || timeComponents[1].contains("pm") {
            if hour == 12 {
                time24 = "12:\(minutes)"
            } else {
                time24 = "\(hour + 12):\(minutes)"
            }
        } else {
            return "ivalid time format"
        }
        return time24
    }
    
    func convertTimeFrom24To12(time24: String) -> String {
        if time24 == "" {
            return ""
        }
        let timeComponents = time24.components(separatedBy: " ")
        guard timeComponents.count == 2,
              let hour = Int(timeComponents[0]),
              let minutes = Int(timeComponents[1]) else {
            return "ivalid time format"
        }
        
        var time12 = ""
        var period = ""
        
        if hour == 0 {
            time12 = "12:\(minutes)"
            period = " AM"
        } else if hour == 12 {
            time12 = "12:\(minutes)"
            period = " PM"
        } else if hour > 12 {
            time12 = "\(hour - 12):\(minutes)"
            period = " PM"
        } else {
            time12 = "\(hour):\(minutes)"
            period = " AM"
        }
        
        return time12 + period
    }
    
    func convertDateFormat(inputDateString: String) -> String {
        let inputDateFormat = Constants.dateFormat
        let outputDateFormat = "dd MMM yyyy, HH:mm"
        var outputDateString = String()
        
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputDateFormat
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = outputDateFormat
        
        if let inputDate = inputDateFormatter.date(from: inputDateString) {
            outputDateString = outputDateFormatter.string(from: inputDate)
        }
        
    return outputDateString

    }
}

//MARK: - UINavigationController
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
//MARK: - UIView
extension UIView {
    func setBorderWithroundCorner(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor

        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
            
    }
    
    func setShadow(shadowRadius: CGFloat, opacity: Float) {
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    
    // Add borderWidth in Story Bord
    @IBInspectable var borderWidth: CGFloat
        {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    // Add cornerRadius in Story Bord
    @IBInspectable var cornerRadius: CGFloat
        {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    // Add borderColor in Story Bord
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

//MARK: - UILabel
extension UILabel {
    
    func initLabel(title: String, titleColor: UIColor, backgroundColor: UIColor, aliggment: NSTextAlignment, font: ChooseFont, fontSize: CGFloat) {
        self.textAlignment = aliggment
        self.text = title
        self.textColor = titleColor
        self.backgroundColor = backgroundColor
        self.font = UIFont(name: CustomFont(index: font), size: fontSize)
    }
}

//MARK: - UIButton
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

//MARK: - UIImage
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

//MARK: - String
extension String? {
    func isNilOrEmpty() -> Bool {
        return self == nil || ((self?.isEmpty) == true)
    }
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
