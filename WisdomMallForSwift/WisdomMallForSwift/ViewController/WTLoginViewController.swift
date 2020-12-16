//
//  WTLoginViewController.swift
//  WisdomMallForSwift
//
//  Created by Able-Fangjing on 2020/12/14.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

import UIKit
import SnapKit

protocol ValidatePhoneNumber {
    func validatePhoneNumber(_ phoneNum: String) -> Bool
}

protocol ValidatePassWord {
    func validatePassWord(_ password: String) -> Bool
}

extension ValidatePhoneNumber {
    func validatePhoneNumber(_ phoneNum: String) -> Bool {
        if phoneNum.count != 11 {
            return false
        }
        return true
    }
}

extension ValidatePassWord {
    func validatePassWord(_ password: String) -> Bool {
        if password.count < 6 || password.count > 12 {
            return false
        }
        return true
    }
}

class WTLoginViewController: WTBaseViewController, ValidatePhoneNumber, ValidatePassWord {

    var phoneTextField: UITextField!
    var passwordTextField: UITextField!
    var loginSuccessBlock: ((_ name: String, _ headPic: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "登录"
        self.setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        let logoView = UIImageView(image: R.image.logo())
        view.addSubview(logoView)
        logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        let phoneIconView = UIImageView(image: R.image.icon_phone())
        phoneTextField = UITextField()
        phoneTextField.leftView = phoneIconView
        phoneTextField.leftViewMode = .always
        phoneTextField.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        phoneTextField.layer.borderWidth = 1
        phoneTextField.textColor = UIColor.hexColor(0x333333)
        phoneTextField.layer.cornerRadius = 4
        phoneTextField.layer.masksToBounds = true
        phoneTextField.placeholder = "请输入手机号"
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp_bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        let passwordIconView = UIImageView(image: R.image.icon_pwd())
        passwordTextField = UITextField()
        passwordTextField.leftView = passwordIconView
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.textColor = UIColor.hexColor(0x333333)
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.layer.masksToBounds = true
        passwordTextField.placeholder = "请出入密码"
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp_bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.layer.cornerRadius = 4
        loginBtn.layer.masksToBounds = true
        loginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginBtn.backgroundColor = UIColor.hexColor(0xf8892e)
        loginBtn.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for: .normal)
        loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTextField.snp_bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc func loginAction() {
        if validatePhoneNumber(phoneTextField.text ?? "") && validatePassWord(passwordTextField.text ?? "") {
            //登录
            if loginSuccessBlock != nil {
                loginSuccessBlock!("方静", "https://static001.geekbang.org/resource/image/30/86/307332b7ba9556ba1e38c358ad6aab86.jpg")
            }
            navigationController?.popViewController(animated: true)
        }else {
            self.showToast()
        }
    }
    
    func showToast() {
        let alertVC = UIAlertController(title: "提示", message: "用户名或者密码错误", preferredStyle: .alert)
        present(alertVC, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertVC.dismiss(animated: true, completion: nil)
        }
    }
}
