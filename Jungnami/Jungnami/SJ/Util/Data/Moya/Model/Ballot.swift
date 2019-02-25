//
//  Ballot.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Foundation

struct Ballot: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data : Int?
}
