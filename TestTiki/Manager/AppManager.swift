//
//  AppManager.swift
//  TestTiki
//
//  Created by Huy Trần on 7/7/24.
//

import UIKit

class AppManager {
    
    private(set) var window: UIWindow?

    let deviceOS = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
    
    private (set) static var shared = AppManager()
    
    lazy var networkManager: NetworkManager = {
        let networkManager = NetworkManager(apiService: APIService(baseURL: "https://run.mocky.io"))
        return networkManager
    }()
}
