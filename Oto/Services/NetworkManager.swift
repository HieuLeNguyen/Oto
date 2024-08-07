//
//  NetworkManager.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 4/8/24.
//

import Foundation
import Alamofire


enum NetworkError: Error {
    case invalidURL
    case noData
    case apiError(ErrorRes)
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    var token = ""
    
    init(token: String = "") {
        self.token = token
    }
    
    //MARK: request
    func request<T: Decodable>(
        url: String,
        parameters: [String: Any]? = nil,
        method: HTTPMethod = .get,
        callback: @escaping (Result<T, NetworkError>)-> ()
    ) -> Void {
        // Check url
        guard let url = URL(string: url) else {
            callback(.failure(NetworkError.invalidURL))
            return
        }
        
        // Option add token
        let headers = HTTPHeaders.commonHeader(token: token)
        
        // Encoding send with post
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    print("Response: \(value)")
                    callback(.success(value))
                    
                case .failure(let error):
                    // Log the error if needed
                    print("Request failed with error: \(error)")
                    
                    if let data = response.data {
                        do {
                            let apiErrorResponse = try JSONDecoder().decode(ErrorRes.self, from: data)
                            callback(.failure(.apiError(apiErrorResponse)))
                        } catch {
                            let decodingError = ErrorRes(message: "Decoding error: \(error.localizedDescription)", errors: nil)
                            callback(.failure(.apiError(decodingError)))
                        }
                    } else {
                        let unknownError = ErrorRes(message: "Unknown error occurred", errors: nil)
                        callback(.failure(.apiError(unknownError)))
                    }
                }
            }
    }
}

extension HTTPHeaders {
    static func commonHeader(token: String? = nil) -> HTTPHeaders {
        
        var header: HTTPHeaders = ["Accept": "application/json"]
        
        if let token = token {
            header.add(authorization: token)
        }
        
        return header
    }
    
    private mutating func add(authorization token: String) {
        self.add(name: "Authorization", value: "Bearer \(token)")
    }
    
}
