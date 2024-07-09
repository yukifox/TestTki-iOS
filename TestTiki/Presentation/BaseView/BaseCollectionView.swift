//
//  BaseCollectionView.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//

import UIKit

class BaseCollectionView: UICollectionView {
    var completionHandler: (() -> Void)?
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.refreshControl = refresher
        return refresher
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
