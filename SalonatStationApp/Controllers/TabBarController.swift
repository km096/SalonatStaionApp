//
//  TabBarController.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/19/23.
//

import UIKit

class TabBarController: UITabBarController {

    var upperLineView: UIView!

    let spacing: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
               self.addTabbarIndicatorView(index: 0, isFirstTime: true)
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
    }
    
    func setupTabBar() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5)], for: .normal)
        tabBar.tintColor = #colorLiteral(red: 0.9552590251, green: 0.4643781185, blue: 0.4304232001, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.9552590251, green: 0.4643781185, blue: 0.4304232001, alpha: 1).withAlphaComponent(0.5)
        
    }

    ///Add tabbar item indicator uper line
      func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
          guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
              return
          }
          if !isFirstTime{
              upperLineView.removeFromSuperview()
          }
          upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1 , width: tabView.frame.size.width - spacing * 2, height: 10))
          upperLineView.layer.cornerRadius = 10
          upperLineView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
          upperLineView.layer.masksToBounds = false
          upperLineView.backgroundColor = UIColor.systemPink
          tabBar.addSubview(upperLineView)
      }

}


extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: self.selectedIndex)
    }
}
