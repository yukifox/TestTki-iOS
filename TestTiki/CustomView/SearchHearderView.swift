//import UIKit
//
//class SearchHearderView: BaseView {
//    static let height: CGFloat = 56
//    
//    lazy var containerSearchView: UIView = {
//        let containerSearchView = UIView()
//        containerSearchView.backgroundColor = Color.white
//        return containerSearchView
//    }()
//    
//    private lazy var searchButton: UIButton = {
//        let searchButton = UIButton()
//        searchButton.backgroundColor = ColorExtension.clear
//        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
//        return searchButton
//    }()
//    
//    private lazy var searchImageView: UIImageView = {
//        let searchImageView = UIImageView()
//        searchImageView.image = UIImage(named: Images.Icon.Order.orderSearch.rawValue)?.withBackground(color: ColorExtension.backgroundPrimary)
//        return searchImageView
//    }()
//    
//    private lazy var dividerLine: UIView = {
//        let dividerLine = UIView()
//        dividerLine.backgroundColor = ColorExtension.divider
//        return dividerLine
//    }()
//    
//    override func setupUI() {
//        super.setupUI()
//        addSubview(containerSearchView)
//        containerSearchView.addMultipleView(categoryMenuButton,
//                                            searchImageView,
//                                            favoriteImageView,
//                                            searchButton,
//                                            favoriteButton,
//                                            dividerLine)
//    }
//    
//    override func setupConstraints() {
//        super.setupConstraints()
//        containerSearchView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        categoryMenuButton.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().offset(UIConstraints.leftPadding)
//            $0.trailing.equalTo(searchButton.snp.leading)
//        }
//        
//        searchButton.snp.makeConstraints {
//            $0.size.equalTo(48)
//            $0.centerY.equalTo(searchImageView.snp.centerY)
//            $0.trailing.equalTo(favoriteButton.snp.leading)
//        }
//        
//        searchImageView.snp.makeConstraints {
//            $0.size.equalTo(24)
//            $0.centerY.equalTo(categoryMenuButton.snp.centerY)
//            $0.leading.equalTo(categoryMenuButton.snp.trailing).offset(UIConstraints.leftPadding)
//        }
//        
//        favoriteImageView.snp.makeConstraints {
//            $0.size.equalTo(24)
//            $0.centerY.equalTo(categoryMenuButton.snp.centerY)
//            $0.leading.equalTo(searchImageView.snp.trailing).offset(UIConstraints.leftPadding)
//            $0.trailing.equalToSuperview().inset(UIConstraints.leftPadding)
//        }
//        
//        favoriteButton.snp.makeConstraints {
//            $0.size.equalTo(48)
//            $0.centerY.equalTo(favoriteImageView.snp.centerY)
//            $0.trailing.equalToSuperview()
//        }
//        
//        dividerLine.snp.makeConstraints {
//            $0.height.equalTo(1)
//            $0.leading.bottom.trailing.equalToSuperview()
//        }
//    }
//    
//    func setupData(title: String,
//                   isShowDividerLine: Bool = false,
//                   thumbnailCat: String? = nil) {
//        categoryMenuButton.setupData(title: title,
//                                     image: Images.Icon.Login.genderDropDown.rawValue,
//                                     imageCat: thumbnailCat)
//    }
//    
//    @objc func favAction() {
//        guard let favoriteActionHandler = favoriteActionHandler else { return }
//        favoriteActionHandler()
//    }
//    
//    @objc func searchAction() {
//        guard let searchActionHandler = searchActionHandler else { return }
//        searchActionHandler()
//    }
//    
//    @objc func openCategoryAction() {
//        guard let categoryActionHandler = categoryActionHandler else { return }
//        categoryActionHandler()
//    }
//
//}
