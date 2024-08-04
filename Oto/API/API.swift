//
//  API.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 23/7/24.
//

import Foundation
import Alamofire
import SwiftyJSON

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
}

class API {
    
    var token = ""
    
    init(token: String = "") {
        self.token = token
    }

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
                callback(.failure(error))
            }
        }
    }
    
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
}


