//
//  LoginResponse.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 27/7/24.
//

import Foundation
<<<<<<< HEAD
=======
 
struct LoginResponse: Decodable {
    let data: LoginData
    let message: String
}

struct LoginData: Decodable {
    let access_token: String
    let token_type: String
}
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
