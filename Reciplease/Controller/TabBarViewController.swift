//
//  ViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 06/04/2021.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - Internal

    // MARK: - Methods - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar()
        addBordureInTabBar()
    }
    
    // MARK: - Private
    
    // MARK: - Methods - Private
    
   private func addBordureInTabBar() {
        let midX = self.view.bounds.midX
        
        let topline = CALayer()
        topline.frame = CGRect(x: 0, y: 0, width: self.tabBar.frame.width, height: 1)
        topline.backgroundColor = UIColor.gray.cgColor
        self.tabBar.layer.addSublayer(topline)
        
        let verticalLine = CALayer()
        verticalLine.frame = CGRect(x:midX, y: 0, width: 1, height: self.tabBar.frame.height)
        verticalLine.backgroundColor = UIColor.gray.cgColor
        self.tabBar.layer.addSublayer(verticalLine)
    }

    private func customTabBar() {
        let uiTabBarItem = UITabBarItem.appearance()
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 22)]
        uiTabBarItem.setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        uiTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
    }

}
