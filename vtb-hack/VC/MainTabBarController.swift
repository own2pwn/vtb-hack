//
//  MainTabBarController.swift
//  StopSmoking
//
//  Created by Semyon on 04.10.2020.
//

import UIKit

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.delegate = self
        setupColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupColor() {
        let tabBarColor = Color.VTB.Blue.blue100
        tabBar.isTranslucent = true
        tabBar.tintColor = .white
        tabBar.barTintColor = tabBarColor
    }
}
