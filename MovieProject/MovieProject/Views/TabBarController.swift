//
//  ViewController.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 14.04.2023.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {
    
    //MARK: - View properties
    private let homeView = HomeView()
    private let searchView = SearchView()
    private let userView = ProfileView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarSetting()
    }
}

//MARK: - Setup TabBar
private extension TabBarController {
    func tabbarSetting() {
        homeView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchView.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        userView.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        viewControllers = [homeView, searchView, userView]
        
        tabBar.tintColor = Color.selectItemsTabbar
    }
}



