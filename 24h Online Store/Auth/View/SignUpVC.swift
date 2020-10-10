//
//  SignUpVC.swift
//  24h Online Store
//
//  Created by macboock pro on 9/28/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SignUpVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    let signUpViewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    //var encodingImage:String = ""
    var encodingImage = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToSignUpButton()
        subscribeIsValidSignUp()
        subscribeToResponse()
    }
    func setupUI() {
        
        profileImage.makeRounded()
        nameTF.makeRounded()
        phoneNumTF.makeRounded()
        emailTF.makeRounded()
        passwordTF.makeRounded()
        signUpButton.makeRounded()
        
        
        passwordTF.setIcon()
        makeGestureRecognizer()
    }
    func makeGestureRecognizer() {
        //to show or hide  password
        let showOrHidePasswordGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldImageTapped(tapGestureRecognizer:)))
        passwordTF.rightView?.isUserInteractionEnabled = true
        passwordTF.rightView?.addGestureRecognizer(showOrHidePasswordGestureRecognizer)
        
        //to open image gallery when tapped profileImage
        let tapedProfileImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapedProfileImageGestureRecognizer)
        
    }
    @objc func textFieldImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        passwordTF.isSecureTextEntry ? passwordTF.setIcon("eye.slash.fill"):passwordTF.setIcon("eye.fill")
        passwordTF.isSecureTextEntry.toggle()
        passwordTF.rightView?.isUserInteractionEnabled = true
        passwordTF.rightView?.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType =  .photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
       
    }
    func bindTextFieldsToViewModel() {
        nameTF.rx.text.orEmpty.bind(to: signUpViewModel.nameBehavior).disposed(by: disposeBag)
        phoneNumTF.rx.text.orEmpty.bind(to: signUpViewModel.phoneBehavior).disposed(by: disposeBag)
        emailTF.rx.text.orEmpty.bind(to: signUpViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTF.rx.text.orEmpty.bind(to: signUpViewModel.passwordBehavior).disposed(by: disposeBag)
    
        encodingImage.bind(to: signUpViewModel.profileImageBehavior).disposed(by: disposeBag)
        // profileImage.rx.text.orEmpty.bind(to: signUpViewModel.nameBehavior).disposed(by: disposeBag)
        
    }
    func subscribeToLoading() {
        signUpViewModel.indecatorLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.signUpButton.showAnimatingDots()
            } else {
                self.signUpButton.hideAnimatingDots()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToSignUpButton() {
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.signUpViewModel.signUp()
            }).disposed(by: disposeBag)
    }
    func subscribeIsValidSignUp() {
        signUpViewModel.isValid().bind(to: signUpButton.rx.isEnabled).disposed(by: disposeBag)
        signUpViewModel.isValid().map({ $0 ? 1:0.2
        }).bind(to: signUpButton.rx.alpha).disposed(by: disposeBag)
        
    }
    func subscribeToResponse() {
        signUpViewModel.messageError.subscribe(onNext: {
            if $0.status == false {
                self.makeAlert(title:"Sorry!", message:$0.message)
            }
        }).disposed(by: disposeBag)
    }
}
//MARK: - UIImagePickerControllerDelegate
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate 
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image_data = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            profileImage.image = image_data
            profileImage.backgroundColor = .systemBackground
            let imageData:Data = image_data.pngData()!
            encodingImage.onNext(imageData.base64EncodedString()) 
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
