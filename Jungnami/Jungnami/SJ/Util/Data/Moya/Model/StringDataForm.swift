//
//  StringDataForm.swift
//  Jungnami
//
//  Created by 강수진 on 25/02/2019.
//

import Foundation
struct StringDataForm: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: String?
}
