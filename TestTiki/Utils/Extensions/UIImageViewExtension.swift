//
//  UIImageViewExtension.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//
import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageURLString(_ urlString: String?,
                           size: CGSize? = nil) {
        if let urlString = urlString,
           let url = URL(string: urlString) {
            var context = [SDWebImageContextOption : Any]()
            if let checkSize = size {
                let transformer = SDImageResizingTransformer(size: checkSize,
                                                             scaleMode: .aspectFill)
                context = [.imageTransformer: transformer]
            }
            self.sd_setImage(with: url,
                             placeholderImage: nil,
                             context: context)
        }
    }
}
