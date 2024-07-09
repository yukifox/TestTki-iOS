//
//  HomeViewController.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//
import UIKit
import SnapKit
import RxDataSources

class HotSearchViewController: BaseViewController {
    private let viewModel = HotSearchViewModel()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = Color.white
        searchBar.isUserInteractionEnabled = false
        searchBar.text = "Tìm kiếm"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = Color.black
        return searchBar
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Color.black
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.text = "Search_HotSearch".txt
        return titleLabel
    }()
    
    private lazy var reloadLabel: PaddingLabel = {
        let reloadLabel = PaddingLabel()
        reloadLabel.textColor = Color.black
        reloadLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        reloadLabel.text = "Reload".txt
        let gesture = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        reloadLabel.addGestureRecognizer(gesture)
        return reloadLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = .init(width: 100, height: 100)
        flowLayout.minimumLineSpacing = UIConstraints.betweenPadding
        flowLayout.minimumInteritemSpacing = UIConstraints.betweenPadding / 2
        
        
        let collectionView = BaseCollectionView(frame: .zero,
                                                collectionViewLayout: flowLayout)
        collectionView.register(HotSearchCollectionViewCell.self,
                                forCellWithReuseIdentifier: HotSearchCollectionViewCell.className)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0,
                                            left: UIConstraints.betweenPadding,
                                            bottom: 0,
                                            right: UIConstraints.betweenPadding)
        collectionView.backgroundColor = Color.white
        
        return collectionView
    }()
    
    private lazy var dataSource: RxCollectionViewSectionedReloadDataSource<HotSearchViewModel.SectionOfHotsearch> = {
        let dataSource =  RxCollectionViewSectionedReloadDataSource<HotSearchViewModel.SectionOfHotsearch>(
            configureCell: { dataSource, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSearchCollectionViewCell.className, for: indexPath) as! HotSearchCollectionViewCell
                cell.setupData(data: item)
                return cell
            }
        )
        return dataSource
    }()
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData.onNext(())
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = Color.white
        view.addSubview(searchBar)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(reloadLabel)
    }
    
    override func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(UIConstraints.betweenPadding)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).inset(UIConstraints.betweenPadding)
            $0.leading.trailing.equalToSuperview().inset(UIConstraints.leftPadding)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIConstraints.betweenPadding)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        reloadLabel.snp.makeConstraints {
            $0.center.equalTo(collectionView)
            $0.height.equalTo(20)
            
        }
    }
    
    override func setupRX() {
        super.setupRX()
        setupRxGeneral(viewModel: viewModel)
        
        viewModel
            .sections
            .do { [weak self] _  in
                guard let self = self else { return }

            }.bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel
            .showReloadButton
            .subscribe(onNext: { [weak self] isShow in
                if isShow {
                    self?.reloadLabel.isHidden = false
                    self?.reloadLabel.isUserInteractionEnabled = true
                } else {
                    self?.reloadLabel.isHidden = true
                    self?.reloadLabel.isUserInteractionEnabled = false
                }
            }).disposed(by: disposeBag)
        
    }
}

extension HotSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel(frame: CGRect.zero)
        let item =  viewModel.sections.value[indexPath.section].items[indexPath.item]
        let title = item.name
        label.text = item.name
                    label.sizeToFit()
        let components = title!.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        if words.count > 1 {
            let width = label.frame.width / 2 + UIConstraints.leftPadding
            return CGSize(width: (HotSearchCollectionViewCell.minimumWidth < width) ? width : HotSearchCollectionViewCell.minimumWidth,
                          height: 150)
        } else {
            return .init(width: HotSearchCollectionViewCell.minimumWidth, height: 150)
        }
    }
    
    @objc private func reloadTapped() {
        viewModel.fetchData.onNext(())
    }
    
    
    
}


