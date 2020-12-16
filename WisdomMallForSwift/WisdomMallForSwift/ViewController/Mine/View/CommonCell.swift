//
//  CommonCell.swift
//  WisdomMallForSwift
//
//  Created by Able-Fangjing on 2020/12/16.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CommonCell: UIControl {
    var title: String? {
        didSet {
            self.titleView.text = self.title
        }
    }
    var icon: UIImage? {
        didSet {
            self.iconView.image = self.icon
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = isHighlighted
            if self.isHighlighted {
                self.hilightView.alpha = 0
                self.hilightView.isHidden = false
            } else{
                UIView.animate(withDuration: 0.5, animations: {
                    self.hilightView.alpha = 1
                }) { finished in
                    self.hilightView.isHidden = true
                }
            }
        }
    }
    
    var titleView: UILabel
    var iconView: UIImageView
    var bottomLine: UIView
    var arrowView: UIImageView

    var hilightView: UIView
    
    override init(frame: CGRect) {
        titleView = UILabel()
        iconView = UIImageView()
        bottomLine = UIView()
        arrowView = UIImageView(image: R.image.icon_right_arrow())
        hilightView = UIView()
        super.init(frame: frame)
        self.setUI()
    }
    
    func setUI() {
        
        self.addSubview(hilightView)
        hilightView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        hilightView.isHidden = true
        hilightView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        self.addSubview(titleView)
        titleView.textColor = UIColor.hexColor(0x333333)
        titleView.font = UIFont.systemFont(ofSize: 15)
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp_right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(arrowView)
        arrowView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(bottomLine)
        bottomLine.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1 / UIScreen.main.scale)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
