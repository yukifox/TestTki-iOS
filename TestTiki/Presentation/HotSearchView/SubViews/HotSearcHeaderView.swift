//
//  HotSearcHeaderView.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//

import UIKit
import SnapKit

class HotSearchHeaderView: UICollectionReusableView {
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Color.white
        return containerView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(UIConstraints.leftPadding)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
