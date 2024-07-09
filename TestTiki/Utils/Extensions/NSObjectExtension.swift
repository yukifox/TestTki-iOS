//
//  NSObject.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
