//
//  API.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 23/7/24.
//

import Foundation
import Alamofire
import SwiftyJSON

<<<<<<< HEAD
struct LoginResponse: Decodable {
    let token: String
    let user: User
}

struct User: Decodable {
    let id: Int
    let name: String
    let numberPhone: String
}

struct Salary: Decodable {
    let id: Int
    let amount: Double
    let date: String
=======
//extension HTTPHeaders {
//    static func commonHeader(token: String? = nil) -> HTTPHeaders {
//        
//        var header: HTTPHeaders = ["Accept": "application/json"]
//        
//        if let token = token {
//            header.add(authorization: token)
//        }
//        
//        return header
//    }
//    
//    private mutating func add(authorization token: String) {
//        self.add(name: "Authorization", value: "Bearer \(token)")
//    }
//    
//}

enum APIError: Error {
    case decodingError(String)
    case serverError(String)
    case unknownError(Error)
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
}

class API {
    
    var token = ""
    
    init(token: String = "") {
        self.token = token
    }
<<<<<<< HEAD

    let base = "http://localhost:8000/api"
    
    //    MARK: - Login
    func login(
        params: [String: String],
        callback: @escaping (Result<LoginResponse, Error>)-> ()
    ) {
        let url = base + "/login"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let value):
                callback(.success(value))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    //    MARK: - Forgot Password
    func forgotPassword(
        params: [String: String],
        callback: @escaping (Result<Bool, Error>)-> ()
    ) {
        let url = base + "/forgot_password"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseDecodable(of: Bool.self) { response in
            switch response.result {
            case .success(let value):
                callback(.success(value))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    // MARK: - Logout
    func logout(callback: @escaping (Result<Bool, Error>)-> ()) {
        let url = base + "/logout"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .post, headers: headers).responseDecodable(of: Bool.self) { response in
            switch response.result {
            case .success(let value):
                callback(.success(value))
            case .failure(let error):
=======
    
    let base = "http://localhost:8000/api"
    
    
    private func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        params: [String: Any]? = nil,
        callback: @escaping (Result<T, ErrorResponse>)-> ()
    ) {
        let url = base + endpoint
        
        let headers = HTTPHeaders.commonHeader(token: token)
        
        AF.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseDecodable(of: T.self) { response in
             switch response.result {
             case .success(let value):
                 print("Response: \(value)")
                 callback(.success(value))
                 
             case .failure(_):
                 if let data = response.data {
                     do {
                         let apiErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                         callback(.failure(apiErrorResponse))
                     } catch {
                         let decodingError = ErrorResponse(message: "Decoding error: \(error.localizedDescription)", errors: nil)
                         callback(.failure(decodingError))
                     }
                 } else {
                     let unknownError = ErrorResponse(message: "Unknown error occurred", errors: nil)
                     callback(.failure(unknownError))
                 }
             }
         }
    }
    
    //    MARK: - Login
    func login(
        params: [String: String],
        callback: @escaping (Result<LoginResponse, ErrorResponse>)-> ()
    ) {
        request(endpoint: "/login", method: .post, params: params, callback: callback)
    }
    
    // MARK: - Logout
    func logout(callback: @escaping (Result<Bool, ErrorResponse>)-> ()) {
//        request(endpoint: "/logout", method: .post, callback: callback)
        request(endpoint: "/logout", method: .post) { (result: Result<LogoutResponse, ErrorResponse>) in
            switch result {
            case .success(_):
                callback(.success(true))
                print(1)
                
            case .failure(let error):
                print(2)
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
                callback(.failure(error))
            }
        }
    }
    
<<<<<<< HEAD
    // MARK: - Get Salary Month
    func getSalaryMonth(callback: @escaping (Result<[Salary], Error>)-> ()) {
        let url = base + "/salary/month"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: [Salary].self) { response in
            switch response.result {
            case .success(let value):
                callback(.success(value))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    // MARK: - Get Salary Week
    func getSalaryWeek(id: Int, callback: @escaping (Result<[Salary], Error>)-> ()) {
        let url = base + "/salary/week/\(id)"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: [Salary].self) { response in
            switch response.result {
            case .success(let value):
                callback(.success(value))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    // MARK: - Check In
    func checkIn(callback: @escaping (Result<Bool, Error>)-> ()) {
        let url = base + "/checkin"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .post, headers: headers).responseDecodable(of: Bool.self) { response in
            switch response.result {
            case .success(let value):
                callback(.success(value))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
=======
    // MARK: - Get Info User
    func infoUser(callback: @escaping (Result<UserResponse, ErrorResponse>)-> ()) {
        request(endpoint: "/user", callback: callback)
    }
    
    // MARK: - Get Salary Month
//    func getSalaryMonth(callback: @escaping (Result<[Salary], Error>)-> ()) {
//        
//    }
//    
//    // MARK: - Get Salary Week
//    func getSalaryWeek(id: Int, callback: @escaping (Result<[Salary], Error>)-> ()) {
//        
//    }
//    
//    // MARK: - Check In
//    func checkIn(callback: @escaping (Result<Bool, Error>)-> ()) {
//        
//    }
    //    MARK: - Forgot Password
//    func forgotPassword(
//        params: [String: String],
//        callback: @escaping (Result<Bool, ErrorResponse>)-> ()
//    ) {
//        request(endpoint: "/forgot_password", method: .post, params: params, callback: callback)
//    }
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
}


