//
//  ErrorsRes.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 4/8/24.
//

import Foundation

// MARK: - ErrorRes
struct ErrorRes: Codable {
    let message: String
    let errors: Errors?
    
    struct Errors: Codable {
        let phone: [String]?
        let password: [String]?
    }
}
