//
//  APIRequest.swift
//  TestTiki
//
//  Created by Huy Trần on 6/7/24.
//
import Foundation

public enum RequestType: String {
    case GET, POST
}

protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : Any] { get }
}

enum EncodedType {
    case json
    case formEncoded
}

extension APIRequest {
    
    
    func request(with baseURL: URL,
                 encodeType: EncodedType = .json) -> URLRequest {
        guard var components = URLComponents(url: path.count > 0 ? baseURL.appendingPathComponent(path) : baseURL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        if method == RequestType.GET,
           parameters.count > 0 {
            components.queryItems = parameters.map {
                URLQueryItem(name: String($0), value: String(describing: $1))
            }
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let currentLanguage = LanguageManager.currentLanguage?.rawValue ?? LanguageType.vi.rawValue
        request.setValue(currentLanguage, forHTTPHeaderField: "Accept-Language")
        
        let userAgent = "\(AppManager.shared.deviceOS)"

        request.setValue("(\(userAgent))", forHTTPHeaderField: "User-Agent")
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            request.setValue(appVersion, forHTTPHeaderField: "Tiki-APP-VERSION")
        }
        
        
        if method == RequestType.POST {
            switch encodeType {
                case .json:
                    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                    } catch {
                        fatalError("Error generate JSON data")
                    }
                case .formEncoded:
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    if let body = parameters
                        .reduce("", { "\($0)\($1.0)=\($1.1)&" })
                        .dropLast()
                        .data(using: .utf8,
                              allowLossyConversion: false) {
                        request.httpBody = body
                    }
            }
           
        }
        
        return request
    }
    
}
