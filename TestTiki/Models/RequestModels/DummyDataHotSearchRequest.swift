//
//  DummyDataHotSearchRequest.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//

struct DummyDataHotSearchRequest: APIRequest {

    var method: RequestType
    
    var path: String

    var parameters: [String : Any]
    
    init(params: [String: Any] = [:]) {
        method = RequestType.GET
        path = "v3/a77bae2c-7161-4544-8ea0-51c2dd437328"
        parameters = params
    }
}
