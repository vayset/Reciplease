//
//  ViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 06/04/2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar()
        addBordureInTabBar()
    }
    
    func addBordureInTabBar() {
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

    func customTabBar() {
        let uiTabBarItem = UITabBarItem.appearance()
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 22)]
        uiTabBarItem.setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        uiTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
