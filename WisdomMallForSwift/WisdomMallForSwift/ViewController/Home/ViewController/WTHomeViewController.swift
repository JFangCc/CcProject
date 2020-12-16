//
//  WTHomeViewController.swift
//  WisdomMallForSwift
//
//  Created by Able-Fangjing on 2020/12/14.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

import UIKit
import Kingfisher

class WTHomeViewController: WTBaseViewController, UITableViewDelegate, UITableViewDataSource,BannerViewDataSource, BannerViewDelegate {
    
    var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    let bannerView: BannerView = BannerView(frame: CGRect(x: 0, y: 0, width: 0, height: 176))
    var items: [Course] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "首页"
        self.setupUI()
        self.items = FakeData.createCourses()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = false
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bannerView.isInfinite = true
        bannerView.autoScrollInterval = 2
        bannerView.dataSource = self
        bannerView.delegate = self
        tableView.tableHeaderView = bannerView
    
    }
    
    //MARK: - tableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView .dequeueReusableCell(withIdentifier: "cellId") as? CourseCell
        if cell == nil {
            cell = CourseCell(style: .subtitle, reuseIdentifier: "cellId")
            cell?.item = items[indexPath.row]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = WTCourseDetailViewController()
        let course = items[indexPath.row]
        detailVC.product = course
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    //MARK: - banner delegate
    func numberOfBanners(_ bannerView: BannerView) -> Int {
        return FakeData.createBanners().count
    }
    
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView {
        if let view = convertView as? UIImageView {
            view.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return view
        }else {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return imageView
        }
    }
    
    func didSelectBanner(_ bannerView: BannerView, index: Int) {
        print(index)
    }
}
