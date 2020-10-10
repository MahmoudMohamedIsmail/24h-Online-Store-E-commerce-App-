//
//  SignUpViewModel.swift
//  24h Online Store
//
//  Created by macboock pro on 10/4/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class SignUpViewModel {
    
    var nameBehavior = BehaviorRelay<String>(value: "")
    var phoneBehavior = BehaviorRelay<String>(value: "")
    var emailBehavior = BehaviorRelay<String>(value: "")
    var passwordBehavior = BehaviorRelay<String>(value: "")
    var profileImageBehavior = BehaviorRelay<String>(value: "")
    
    var indecatorLoading = BehaviorRelay<Bool>(value: false)
    
    private var signUpSuccessModelSubject = PublishSubject<SignUpSuccessModel>()
    
    var messageError: Observable<SignUpSuccessModel> {
        return signUpSuccessModelSubject
    }
    
    func isValid() -> Observable<Bool> {
       return Observable.combineLatest(nameBehavior.asObservable(), phoneBehavior.asObservable(), emailBehavior.asObservable(), passwordBehavior.asObservable(), profileImageBehavior.asObservable()).map { (name,phone,email,password,profileImage) in
            return !name.isEmpty && !phone.isEmpty && !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&  !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !profileImage.isEmpty
        }
    }
    
    func signUp() {
        indecatorLoading.accept(true)

        let body = SignUpRequest(name: nameBehavior.value, phone: phoneBehavior.value, email: emailBehavior.value, password: passwordBehavior.value, image: profileImageBehavior.value)

        APIManager.taskForPOSTRequest(url: APIManager.Endpoints.signUp.url, responseType: SignUpSuccessModel.self, body: body) { signUpSuccessModel, error in
            self.indecatorLoading.accept(false)

            guard let signUpSuccessModel = signUpSuccessModel else {
                print(error!)
                return
            }

            if let data = signUpSuccessModel.data {
                Helper.saveApiToken(token: data.token)

            }
            self.signUpSuccessModelSubject.onNext(signUpSuccessModel)

        }

    }
}
