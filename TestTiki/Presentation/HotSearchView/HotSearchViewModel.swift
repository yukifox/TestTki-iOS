//
//  HomeViewModel.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources

class HotSearchViewModel: BaseViewModel {
    lazy var sections = BehaviorRelay<[SectionOfHotsearch]>.init(value: [])
    typealias SectionOfHotsearch = SectionModel<String, HotsearchModel>
    
    let fetchData = PublishSubject<Void>()
    let showReloadButton = BehaviorRelay<Bool>.init(value: false)
    
    override init() {
        super.init()
    }
    
    override func setupRX() {
        super.setupRX()
        
        fetchData
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.fetchDummyData()
            }.disposed(by: disposeBag)
    }
    
    private func fetchDummyData() {
        self.showLoading.accept(true)
        let request = DummyDataHotSearchRequest()
        let result: Observable<DataHotSearchResponseModel> = AppManager.shared.networkManager.apiService.send(apiRequest: request)
        
        result
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] success in
                self?.showLoading.accept(false)
                if let data = success.data?.items {
                    self?.setupCollectionView(data: data)
                    self?.showReloadButton.accept(false)
                } else {
                    self?.showReloadButton.accept(true)
                }
                
            } onError: { [weak self] error in
                self?.showReloadButton.accept(true)
                guard let self,
                      let error = error as? APIServiceError else { return }
                showLoading.accept(false)
                showAlertWithAPIServiceError.accept(error)
            }.disposed(by: disposeBag)
    }
    
    private func setupCollectionView(data: [HotsearchModel]) {
        var section = [SectionOfHotsearch]()
        var data = data
        for (index, _) in data.enumerated() {
            if index < UIConstraints.listColorBackground.count {
                data[index].color = UIConstraints.listColorBackground[index]
            } else {
                let newIndex = index % UIConstraints.listColorBackground.count
                data[index] = data[newIndex]
            }
        }
        
        section.append(.init(model: "Search_HotSearch".txt, items: data))
        sections.accept(section)
        
    }
    
}

