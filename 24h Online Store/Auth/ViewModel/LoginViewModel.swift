//
//  LoginViewModel.swift
//  24h Online Store
//
//  Created by macboock pro on 10/3/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class LoginViewModel {
    
    var emailBehavior = BehaviorRelay<String>(value: "")
    var passwordBehavior = BehaviorRelay<String>(value: "")
    var indecatorLoading = BehaviorRelay<Bool>(value: false)
    private var loginSuccessModelSubject = PublishSubject<LoginSuccessModel>()
    var messageError: Observable<LoginSuccessModel> {
        return loginSuccessModelSubject
    }
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(emailBehavior.asObservable(), passwordBehavior.asObservable()).map { (email,password) in
            return !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&  !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    func login() {
        indecatorLoading.accept(true)
        let body = LoginRequest(email: emailBehavior.value, password: passwordBehavior.value)
        
        APIManager.taskForPOSTRequest(url: APIManager.Endpoints.login.url, responseType: LoginSuccessModel.self, body: body) { loginSucceessModel, error in
            self.indecatorLoading.accept(false)
            
            guard let loginSucceessModel = loginSucceessModel else {
                print(error!)
                return
            }
            
            if let data = loginSucceessModel.data {
                Helper.saveApiToken(token: data.token)
                
            }
            self.loginSuccessModelSubject.onNext(loginSucceessModel)
            
        }
        
    }
}
