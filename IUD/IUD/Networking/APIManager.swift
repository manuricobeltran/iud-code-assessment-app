//
//  APIManager.swift
//  IUD
//
//  Created by Manu Rico on 16/1/22.
//

import Foundation
import Alamofire

typealias HttpSuccess = (_ data: Any) -> Void
typealias HttpFailure = (_ error: Error) -> Void

struct APIManager {

  static let url = "https://hello-world.innocv.com/api/user"

  static func fetchUsers(success: @escaping HttpSuccess, failure: @escaping HttpFailure) {
    AF.request(APIManager.url)
      .validate()
      .responseDecodable(of: [User].self, queue: .main, decoder: JSONDecoder()) { response in
        switch response.result {
        case let .success(data):
          success(data)
        case let .failure(error):
          failure(error)
        }
      }
  }
}
