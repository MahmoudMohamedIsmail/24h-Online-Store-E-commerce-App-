//
//  LogInVC.swift
//  24h Online Store
//
//  Created by macboock pro on 9/27/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        emailTF.text = "ismail.is@gmail.com"
        passwordTF.text = "123456"
        
        
        bindTextFieldsToViewModel()
        subscribeIsValidLogin()
        subscribeToLoading()
        subscribeToLoginButton()
        subscribeToResponse()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupUI() {
        
        emailTF.makeRounded()
        passwordTF.makeRounded()
        loginButton.makeRounded()
        
        //to show or hide  password
        passwordTF.setIcon()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        passwordTF.rightView?.isUserInteractionEnabled = true
        passwordTF.rightView?.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        passwordTF.isSecureTextEntry ? passwordTF.setIcon("eye.slash.fill"):passwordTF.setIcon("eye.fill")
        passwordTF.isSecureTextEntry.toggle()
        passwordTF.rightView?.isUserInteractionEnabled = true
        passwordTF.rightView?.addGestureRecognizer(tapGestureRecognizer)
    }
    func bindTextFieldsToViewModel() {
        emailTF.rx.text.orEmpty.bind(to: loginViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTF.rx.text.orEmpty.bind(to: loginViewModel.passwordBehavior).disposed(by: disposeBag)
    }
    func subscribeToLoading() {
        loginViewModel.indecatorLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.loginButton.showAnimatingDots()
            } else {
                self.loginButton.hideAnimatingDots()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToLoginButton() {
        loginButton.rx.tap
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.loginViewModel.login()
            }).disposed(by: disposeBag)
    }
    func subscribeIsValidLogin() {
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map({ $0 ? 1:0.2
        }).bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
        
    }
    func subscribeToResponse() {
        loginViewModel.messageError.subscribe(onNext: {
            if $0.status == false {
                self.makeAlert(title:"Sorry!", message:$0.message)
            }
        }).disposed(by: disposeBag)
    }
}
