//
//  DataHotSearchResponseModel.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//

struct DataHotSearchResponseModel: Codable {
    let data: ItemHotSearch?
}

// MARK: - ItemHotSearch
struct ItemHotSearch: Codable {
    let items: [HotsearchModel]?
}


