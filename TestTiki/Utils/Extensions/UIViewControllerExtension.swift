//
//  UIViewControllerExtension.swift
//  TestTiki
//
//  Created by Huy Trần on 6/7/24.
//

import Foundation
import UIKit


extension UIViewController {
    func dismissView(_ animated: Bool = true,
                            completion: (() -> Void)? = nil) {
        self.dismiss(animated: animated, completion: completion)
    }
    
    func popView(_ animated: Bool = true) {
        guard let navigation = self.navigationController else {
            return
        }
        navigation.popViewController(animated: animated)
    }
}
