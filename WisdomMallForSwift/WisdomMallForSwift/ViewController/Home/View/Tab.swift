//
//  Tab.swift
//  WisdomMallForSwift
//
//  Created by Able-Fangjing on 2020/12/15.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol TabDelegate: AnyObject {
    func didClickBtn(index: Int)
}

class Tab: UIView {
    var items: [String] = []
    var itemBtns: [UIButton] = []
    var selectedItemButton: UIButton!
    
    var indicatorView: UIView!
    var normalColor: UIColor?
    var selectorColor: UIColor? {
        didSet {
            if let color = self.selectorColor {
                self.indicatorView.backgroundColor = self.selectorColor
                itemBtns.forEach { (btn) in
                    btn.setTitleColor(color, for: .selected)
                }
            }else{
                self.indicatorView.backgroundColor = UIColor.hexColor(0xf8892e)
                itemBtns.forEach { (btn) in
                    btn.setTitleColor(UIColor.hexColor(0xf8892e), for: .selected)
                }
            }
        }
    }
    
    weak var delegate: TabDelegate?
    
    init?(items: [String]) {
        if items.count == 0 {
            return nil
        }
        self.items = items
        super.init(frame: .zero)
        self.setUI()
    }
    
    func setUI(){
        var lastView: UIView!
        for index in 0..<items.count {
            let btn = UIButton()
            btn.tag = index + 100
            btn.setTitle(items[index], for: .normal)
            btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
            btn.setTitleColor(UIColor.hexColor(0xf8892e), for: .selected)
            btn.addTarget(self, action: #selector(didClickBtn(sender:)), for: .touchUpInside)
            self.addSubview(btn)
            if index == 0 {
                selectedItemButton = btn
            }
            btn.snp.makeConstraints { (make) in
                if index == 0 {
                    make.left.equalToSuperview()
                }else{
                    make.left.equalTo(lastView.snp_right)
                    make.width.equalTo(lastView)
                }
                make.top.bottom.equalToSuperview()
                if index == items.count - 1 {
                    make.right.equalToSuperview()
                }
            }
            lastView = btn
            itemBtns.append(btn)
        }
        indicatorView = UIView()
        indicatorView.backgroundColor = UIColor.hexColor(0xf8892e)
        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints({ (make) in
            make.centerX.equalTo(selectedItemButton)
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(4)
        })
    }
    
    @objc private func didClickBtn(sender: UIButton) {
        self.didSelectIndex(index: sender.tag)
    }
    
    func didSelectIndex(index: Int) {
        let sender = self.viewWithTag(index) as! UIButton
        guard sender != selectedItemButton else {
            return
        }
        selectedItemButton.isSelected = false
        sender.isSelected = true
        selectedItemButton = sender
        self.indicatorView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.selectedItemButton)
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(4)
        }
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        delegate?.didClickBtn(index: sender.tag - 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
