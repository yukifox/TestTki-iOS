//
//  APISevice.swift
//  TestTiki
//
//  Created by Huy Trần on 6/7/24.
//

import Foundation
import RxSwift

struct APIServiceResponse: Codable {
    let error: APIServiceError?
}

struct APIServiceError: Codable, Error {
    var statusCode: Int? = 0
    let message: String
    let errorCode: String
    
    // just get data you should use title param below
    private(set) var titleRawStr: String? = nil
    
    var title: String {
        if let titleRawStr = titleRawStr,
           titleRawStr.count > 0 {
            return titleRawStr
        }
        return "AlertErrorTitle".txt
    }
    
    private enum CodingKeys: String, CodingKey {
        case message
        case titleRawStr = "title"
        case errorCode = "error_code"
        case statusCode = "status_code"
    }
}

typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

class APIService {
    
    private let baseURL: URL
    private let networkSession: URLSession
    
   
    
    init(baseURL: String,
         networkSession: URLSession = APIService.session()) {
        self.baseURL = URL(string: baseURL)!
        self.networkSession = networkSession
    }
    
    func  send<T: Codable>(apiRequest: APIRequest,
                          encodedType: EncodedType = .json) -> Observable<T> {
        return Observable<T>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            let request = apiRequest.request(with: self.baseURL,
                                             encodeType: encodedType)
            let task = self.dataTaskWithRequest(request) { [weak self] (data, response, error) in
                guard let self = self else { return }
                self.handleReponse(observer: observer,
                                   request: request,
                                   data: data,
                                   response: response,
                                   error: error)
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func dataTaskWithRequest(_ request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let authFailBlock: CompletionHandler = { [weak self] data, response, error in
            guard let self = self,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == ErrorCode.tokenInvalid.rawValue else {
                completionHandler(data, response, error)
                return }
            
        }
        var request = request
        request.setValue(RequestKey.Header.bearer + RequestKey.Auth.token, forHTTPHeaderField: RequestKey.Header.authorization)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }.resume()
        
        return networkSession.dataTask(with: request, completionHandler: authFailBlock)
    }
    
    private func handleReponse<T: Codable>(observer: AnyObserver<T>,
                                           request: URLRequest,
                                           data: Data? = nil,
                                           response: URLResponse? = nil,
                                           error: Error? = nil) {
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? ErrorCode.unknow.rawValue
            var apiServiceError = APIServiceError(statusCode: statusCode,
                                                  message: ErrorMessage.network.rawValue.txt,
                                                  errorCode: "")
            do {
                let internalError = try JSONDecoder().decode(APIServiceResponse.self, from: data ?? Data())
                if let error = internalError.error {
                    apiServiceError = error
                    apiServiceError.statusCode = statusCode
                }
            } catch {
                
            }
            observer.onError(apiServiceError)
            return
        }
        do {
            let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
            observer.onNext(model)
        } catch (_) {
            observer.onError(APIServiceError(statusCode: ErrorCode.parse.rawValue,
                                             message: ErrorMessage.parse.rawValue.txt,
                                             errorCode: ""))
        }
        observer.onCompleted()
    }
}

extension APIService {
    static func session(withPolicy policy: NSURLRequest.CachePolicy = .useProtocolCachePolicy,
                        sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
                        timeout: TimeInterval = 30) -> URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeout
        return URLSession(configuration: config)
    }
}
