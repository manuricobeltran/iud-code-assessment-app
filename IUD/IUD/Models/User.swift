//
//  User.swift
//  IUD
//
//  Created by Manu Rico on 16/1/22.
//

import Foundation

struct User: Codable {
  let id: Int?
  let name: String?
  let birthdate: Date?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case birthdate
  }
}

extension User {

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)

    let dateString = try container.decode(String.self, forKey: .birthdate)
    let formatter1 = DateFormatter.iso8601CustomLong
    let formatter2 = DateFormatter.iso8601CustomShort
    if let date = formatter1.date(from: dateString) {
      birthdate = date
    } else if let date = formatter2.date(from: dateString) {
      birthdate = date
    } else {
      birthdate = Date()
    }
  }
}
