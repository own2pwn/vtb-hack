//
//  AppRouter.swift
//  StopSmoking
//
//  Created by Semyon on 04.10.2020.
//

import Foundation
import UIKit

final class AppRouter {
    init() {}

    func start(in window: UIWindow) {
        window.rootViewController = createCarRecognizerVC() // createTinderWindow()
        window.makeKeyAndVisible()
    }

    func createTinderVC(groupedOffers: GroupedOffersResponse) -> UINavigationController {
        let rootNavigationController: UINavigationController
        let rootTabBarController: MainTabBarController

        let mainTabRootNavigationController = MainNavigationController(nibName: nil, bundle: nil)
        mainTabRootNavigationController.navigationBar.isTranslucent = false
        mainTabRootNavigationController.navigationBar.barTintColor = Color.primary

        mainTabRootNavigationController.viewControllers = [TinderViewController(groupedOffers: groupedOffers)]
        mainTabRootNavigationController.tabBarItem = UITabBarItem(title: "Исследовать", image: UIImage(named: "tinder"), selectedImage: nil)

        let favoritesTabRootNavigationController = MainNavigationController(nibName: nil, bundle: nil)
        favoritesTabRootNavigationController.viewControllers = [FavoritesViewController()]
        favoritesTabRootNavigationController.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(named: "hearts"), selectedImage: nil)

        rootTabBarController = MainTabBarController(nibName: nil, bundle: nil)
        rootTabBarController.setViewControllers([
            mainTabRootNavigationController,
            favoritesTabRootNavigationController
        ], animated: false)

        rootNavigationController = UINavigationController(
            rootViewController: rootTabBarController
        )
        rootNavigationController.setNavigationBarHidden(true, animated: false)

        return rootNavigationController
    }

    func createCarRecognizerVC() -> UIViewController {
        return ViewController()
    }
}
