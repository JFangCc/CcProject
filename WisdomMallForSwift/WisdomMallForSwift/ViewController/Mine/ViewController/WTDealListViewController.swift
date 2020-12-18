//
//  WTDealListViewController.swift
//  WisdomMallForSwift
//
//  Created by Able-Fangjing on 2020/12/16.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

import UIKit

class WTDealListViewController: WTBaseViewController, CommonListDelegate {

    func didSelectItem<Item>(_ item: Item) {
        if let deal = item as? Deal {
            print(deal.course.desc)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "订单"
        
        let productList = CommonList<Deal, DealListCell>(frame: .zero)
        productList.items = FakeData.createDeals()
        productList.delegate = self
        view.addSubview(productList)
        productList.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
