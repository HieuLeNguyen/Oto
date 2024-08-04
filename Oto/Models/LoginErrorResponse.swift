//
//  ErrorResponse.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 31/7/24.
//

import Foundation

struct ErrorResponse: Codable {
    let message: String
    let errors: [String: [String]]
}
    