//
//  TabBarController.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.barStyle = .black

        
        let item1 = HomeNav()
        let item2 = SearchNav()
        let item3 = WatchlistNav()
        
        
        let icon1 = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "homeSelected"))
        let icon2 = UITabBarItem(title: "Search", image: UIImage(named: "search"), selectedImage: UIImage(named: "searchSelected"))
        let icon3 = UITabBarItem(title: "Watch list", image: UIImage(named: "watchlist"), selectedImage: UIImage(named: "watchlistSelected"))
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        
        tabBar.barTintColor = .black
        tabBar.tintColor = UIColor(named: "bl")
        
        let controllers = [item1, item2, item3]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }
    
}
