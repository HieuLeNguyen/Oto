<<<<<<< HEAD
//
//  UserRes.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 4/8/24.
//

import Foundation
=======
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userResponse = try? JSONDecoder().decode(UserResponse.self, from: jsonData)

import Foundation

// MARK: - UserResponse
struct UserRes: Codable {
    let data: UserDataClass
    let message: String
}

// MARK: - DataClass
struct UserDataClass: Codable {
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let name, phone: String
}
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
