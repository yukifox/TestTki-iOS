//
//  BaseViewModel.swift
//  TestTiki
//
//  Created by Huy Trần on 6/7/24.
//
import UIKit
import RxSwift
import RxRelay

class BaseViewModel: NSObject {
    let disposeBag = DisposeBag()
    let showAlertError = BehaviorRelay<String?>(value: nil)
    let showLoading = BehaviorRelay<Bool>(value: false)
    let showAlertWithAPIServiceError = BehaviorRelay<APIServiceError?>(value: nil)
    let dismissView = BehaviorRelay<Bool>(value: false)
    let popView = BehaviorRelay<Bool>(value: false)

    override init() {
        super.init()
        setupData()
        setupRX()
    }
    
    func setupData() {
        
    }
    
    func setupRX() {
        
    }
}
