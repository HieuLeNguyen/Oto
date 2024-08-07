//
//  APIService.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 4/8/24.
//

import Foundation
<<<<<<< HEAD
=======
import SwiftyJSON

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    // MARK: - Login
    func login(
        params: [String: String],
        callback: @escaping (Result<LoginRes, NetworkError>)-> ()
    ) {
        NetworkManager.shared.request(url: login_url, parameters: params, method: .post, callback: callback)
    }
    
    // MARK: - Logout
    func logout(
        callback: @escaping (Result<LogoutRes, NetworkError>)-> ()
    ) {
        NetworkManager.shared.request(url: logout_url, method: .post, callback: callback)
    }
    
    // MARK: - Get Info User
    func infoUser(
        callback: @escaping (Result<UserRes, NetworkError>)-> ()
    ) {
        NetworkManager.shared.request(url: user_url, callback: callback)
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
}
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
