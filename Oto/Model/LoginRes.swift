<<<<<<< HEAD
//
//  LoginRes.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 4/8/24.
//

import Foundation
=======
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: jsonData)

import Foundation

// MARK: - LoginResponse and RefreshResponse
struct LoginRes: Codable {
    let data: DataClass
    let message: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken, tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
