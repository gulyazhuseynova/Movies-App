//
//  WatchlistNav.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import UIKit

class WatchlistNav: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationBar.barStyle = UIBarStyle.black
        navigationBar.tintColor = UIColor.white
        
        let item1 =  WatchlistVC()
        let controllers = [item1]
        self.viewControllers = controllers
    }
}
