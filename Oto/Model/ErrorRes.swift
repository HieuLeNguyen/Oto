//
//  ErrorsRes.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 4/8/24.
//

import Foundation

// MARK: - ErrorRes
<<<<<<< HEAD
struct ErrorRes: Codable {
=======
struct ErrorRes: Codable, Error {
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
    let message: String
    let errors: Errors?
    
    struct Errors: Codable {
        let phone: [String]?
        let password: [String]?
    }
}
