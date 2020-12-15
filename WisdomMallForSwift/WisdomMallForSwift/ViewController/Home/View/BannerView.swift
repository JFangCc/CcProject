//
//  BannerView.swift
//  WisdomMallForSwift
//
//  Created by Able-Fangjing on 2020/12/14.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol BannerViewDataSource: AnyObject{
    func numberOfBanners(_ bannerView: BannerView) -> Int
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView
}

@objc protocol BannerViewDelegate {
    func didSelectBanner(_ bannerView: BannerView, index: Int)
}

class BannerView: UIView,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var collection: UICollectionView
    var flowLayout: UICollectionViewFlowLayout
    var pageControl: UIPageControl
    
    weak var dataSource: BannerViewDataSource! {
        didSet {
            pageControl.numberOfPages = self.dataSource.numberOfBanners(self)
            collection.reloadData()
            if isInfinite {
                DispatchQueue.main.async {
                    self.collection.setContentOffset(CGPoint(x: self.collection.frame.size.width, y: 0), animated: false)
                }
            }
        }
    }
    weak var delegate: BannerViewDelegate!
    
    var autoScrollInterval: Float = 0 {
        didSet {
            if self.autoScrollInterval > 0 {
                self.startAutoScroll()
            }else {
                self.stopAutoScroll()
            }
        }
    }
    var isInfinite: Bool = true
    var timer: Timer?
    
    static var CellIden = "bannerViewID"
    static var convertViewTag = 10086
    
    override init(frame: CGRect) {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        pageControl = UIPageControl()
        super.init(frame: frame)
        self.setupViews()
        
    }
    
    func setupViews() {
        collection.backgroundColor = .white
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.contentInsetAdjustmentBehavior = .never
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BannerView.CellIden)
        collection.delegate = self
        collection.dataSource = self
        self.addSubview(collection)
        collection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pageNum = dataSource.numberOfBanners(self)
        if isInfinite {
            if pageNum == 1 {
                return 1
            }else {
                return pageNum + 2
            }
        }else {
            return pageNum
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerView.CellIden, for: indexPath)
        var index = indexPath.row
        if isInfinite {
            let pageNum = dataSource.numberOfBanners(self)
            if pageNum > 1 {
                if indexPath.row == 0 {
                    index = pageNum - 1
                }else if indexPath.row == pageNum + 1 {
                    index = 0
                }else {
                    index = indexPath.row - 1
                }
            }
        }
        if let view = cell.contentView.viewWithTag(BannerView.convertViewTag) {
            let _ = dataSource.viewForBanner(self, index: index, convertView: view)
        }else{
            let newView = dataSource.viewForBanner(self, index: index, convertView: nil)
            newView.tag = BannerView.convertViewTag
            cell.contentView.addSubview(newView)
            newView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
        return cell
    }
    
    func startAutoScroll() {
        guard autoScrollInterval > 0 && timer == nil else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(autoScrollInterval), target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopAutoScroll() {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
    }
    
    @objc func timeAction() {
        guard let _ = superview, let _ = window else {
            return
        }
        let totalPageNum = dataSource.numberOfBanners(self)
        guard totalPageNum > 1 else {
            return
        }
        let currentPageNum = Int((collection.contentOffset.x / collection.frame.size.width))
        if isInfinite {
            let nextPageNum = currentPageNum + 1
            collection.setContentOffset(CGPoint(x: CGFloat(nextPageNum) * collection.frame.size.width, y: 0), animated: true)
            pageControl.currentPage = nextPageNum >= totalPageNum + 1 ? 0 : nextPageNum - 1
        }else{
            var nextPageNum = currentPageNum + 1
            if nextPageNum >= totalPageNum {
                nextPageNum = 0
            }
            collection.setContentOffset(CGPoint(x: CGFloat(nextPageNum) * collection.frame.size.width, y: 0), animated: true)
            pageControl.currentPage = nextPageNum
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let totalPageNum = dataSource.numberOfBanners(self)
        let currentPageNum = Int((collection.contentOffset.x / collection.frame.size.width))
        if currentPageNum >= totalPageNum + 1 {
            collection.setContentOffset(CGPoint(x: collection.frame.size.width, y: 0), animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectBanner(self, index: indexPath.item)
    }
}
