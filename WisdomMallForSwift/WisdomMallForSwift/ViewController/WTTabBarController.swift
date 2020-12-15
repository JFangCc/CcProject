//
//  WTTabBarController.swift
//  WisdomMallForSwift
//
//  Created by Able-Fangjing on 2020/12/12.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

import UIKit

class WTTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置不透明tabber
        tabBar.barTintColor = .white
        
        // Do any additional setup after loading the view.
        let homeVC = WTHomeViewController()
        homeVC.tabBarItem.image = R.image.home()
        homeVC.tabBarItem.selectedImage = R.image.home_selected()?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.title = "首页"
        homeVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hexColor(0x333333)], for: .selected)
        let homeNav = UINavigationController(rootViewController: homeVC)
        addChild(homeNav)
        
        let mineVC = WTMineViewController()
        mineVC.tabBarItem.image = R.image.mine()
        mineVC.tabBarItem.selectedImage = R.image.mine_selected()?.withRenderingMode(.alwaysOriginal)
        mineVC.tabBarItem.title = "我的"
        mineVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hexColor(0x333333)], for: .selected)
        let mineNav = UINavigationController(rootViewController: mineVC)
        addChild(mineNav)
    }
}

