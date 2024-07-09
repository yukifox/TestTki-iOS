//
//  BaseViewController.swift
//  TestTiki
//
//  Created by Huy Trần on 6/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay
import MBProgressHUD

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    private weak var viewModel: BaseViewModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad( )
        setupUI()
        setupRX()
        setupConstraints()
    }
    
    func setupUI() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupRX() {
        
    }
    
    func setupRxGeneral(viewModel: BaseViewModel) {
        self.viewModel = viewModel
        
        viewModel
            .showLoading
            .asObservable()
            .subscribe(onNext: { [weak self] isShowLoading in
                guard let self = self else { return }
                self.showLoading(isShowLoading)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .showAlertError
            .asObservable()
            .subscribe(onNext: { [weak self] errorMessage in
                guard let self = self,
                    let message = errorMessage else {
                        return
                }
                endRefresherIfNeeded()
                viewModel.showLoading.accept(false)
                self.showErrorAlert(message: message)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .showAlertWithAPIServiceError
            .asObservable()
            .subscribe(onNext: { [weak self] error in
                guard let self = self,
                      let message = error?.message else {
                        return
                }
                self.endRefresherIfNeeded()
                viewModel.showLoading.accept(false)
                self.showErrorAlert(error?.title,
                                    message: message)
            })
            .disposed(by: disposeBag)
        
        
        viewModel
            .dismissView
            .asObservable()
            .subscribe(onNext: { [weak self] isDissmiss in
                guard let self = self, isDissmiss == true else { return }
                self.dismissView()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .popView
            .asObservable()
            .subscribe(onNext: { [weak self] isDissmiss in
                guard let self = self, isDissmiss == true else { return }
                self.popView()
            }).disposed(by: disposeBag)
        
    }
    
    func showLoading(_ isShow: Bool) {
        if isShow == true {
            let hub: MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
            hub.bezelView.backgroundColor = .clear
        } else {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
    func endRefresherIfNeeded(_ animated: Bool = false) {
        for item in view.subviews {
            if let collectionView = item as? BaseCollectionView {
                guard collectionView.refreshControl != nil else { return }
                if collectionView.contentOffset.y < collectionView.contentInset.top {
                    collectionView.refresher.endRefreshing()
                }
                break
            }
        }
    }
    
    func showErrorAlert(_ title: String? = "AlertErrorTitle".txt,
                        message: String) {
        let action: [UIAlertController.AlertAction] = [.action(title: "AlertActionDone".txt)]
        UIAlertController.present(in: self,
                                  title: title,
                                  message: message,
                                  actions: action)
            .subscribe()
            .disposed(by: disposeBag)
    }
}
