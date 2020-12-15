//
//  WTBaseViewController.swift
//  WisdomMallForSwift
//
//  Created by Able-Fangjing on 2020/12/14.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

import UIKit

class WTBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.hexColor(0xf2f4f7)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.hexColor(0x333333)]
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        // Do any additional setup after loading the view.
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
