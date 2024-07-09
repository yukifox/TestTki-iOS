//
//  BaseView.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupRX()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupUI() {

    }

    func setupConstraints() {

    }
    
    func setupRX() {
        
    }
}
