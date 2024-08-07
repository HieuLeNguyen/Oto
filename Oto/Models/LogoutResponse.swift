//
//  LogoutResponse.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 1/8/24.
//

import Foundation
<<<<<<< HEAD
=======

// MARK: - LogoutResponse
struct LogoutResponse: Decodable {
    var data: [String] = [String]()
    let message: String
}

protocol HTTPStatusCodable {
    var httpStatusCode: Int? { get set }
}

extension LogoutResponse: HTTPStatusCodable {
    var httpStatusCode: Int? {
        get { return nil }
        set { }
    }
}
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
