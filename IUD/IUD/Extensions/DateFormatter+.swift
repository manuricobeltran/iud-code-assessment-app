//
//  DateFormatter+.swift
//  IUD
//
//  Created by Manu Rico on 16/1/22.
//

import Foundation

extension DateFormatter {
  static let iso8601CustomLong: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    formatter.calendar = Calendar(identifier: .iso8601)
    return formatter
  }()
}

extension DateFormatter {
  static let iso8601CustomShort: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    return formatter
  }()
}
