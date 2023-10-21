//
//  CustomTabBar.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/19/23.
//

import UIKit

@IBDesignable
class CustomTabBar: UITabBar {
    
    
    @IBInspectable var color: UIColor?
    @IBInspectable var raduis: CGFloat = 18
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = #colorLiteral(red: 0.9401940703, green: 0.9401939511, blue: 0.9401939511, alpha: 1)
        shapeLayer.lineWidth = 1
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -2)
        shapeLayer.shadowOpacity = 0.21
        shapeLayer.shadowRadius = 8
        shapeLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: raduis).cgPath
        
        shapeLayer.shouldRasterize = true
        shapeLayer.rasterizationScale = UIScreen.main.scale
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: raduis, height: 0)
        )
        
        return path.cgPath
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let bottomPadding = windowScene?.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom

        self.isTranslucent = true
        
        var tabFrame = self.frame
        tabFrame.size.height = 65 + (bottomPadding ?? 0)
        tabFrame.origin.y = self.frame.origin.y + self.frame.height - 65 - (bottomPadding ?? 0)
        self.layer.cornerRadius = 18
        self.frame = tabFrame
        self.items?.forEach({$0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0)})
    }
}

