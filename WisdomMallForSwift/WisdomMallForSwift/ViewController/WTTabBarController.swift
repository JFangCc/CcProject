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
        addChild("首页", R.image.home(), R.image.home_selected()?.withRenderingMode(.alwaysOriginal), WTHomeViewController.self)
        addChild("我的", R.image.mine(), R.image.mine_selected()?.withRenderingMode(.alwaysOriginal), WTMineViewController.self)
    }
    
    func addChild(_ title: String,
                  _ image: UIImage?,
                  _ selectedImage: UIImage?,
                  _ type: UIViewController.Type) {
        let childVc = UINavigationController(rootViewController :type.init())
        childVc.title = title
        childVc.tabBarItem.image = image
        childVc.tabBarItem.selectedImage = selectedImage
        childVc.tabBarItem.title = title
        //设置选中文字颜色
        childVc.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.hexColor(0x333333), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9)
        ], for: .selected)
        addChild(childVc)
    }
}

