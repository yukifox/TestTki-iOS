//
//  UserDefaultExtension.swift
//  TestTiki
//
//  Created by Huy Trần on 6/7/24.
//

import Foundation
extension UserDefaults {
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
}
